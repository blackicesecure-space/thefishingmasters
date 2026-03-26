import { readFileSync } from 'node:fs';
import { join } from 'node:path';
import { ApolloServer } from '@apollo/server';
import { startStandaloneServer } from '@apollo/server/standalone';
import { getSupabase, type SpotRow } from './db/supabase.js';
import { predictBiteProbability, checkMLHealth } from './services/ml-client.js';
import { rankSpots } from './services/scorer.js';

// ----- Types -----

type RecommendationInput = {
  targetSpecies: string;
  waterTempC: number;
  windKmh: number;
  pressureHpa: number;
  moonPhase: number;
  season: string;
  bundesland?: string;
};

type FeedbackInput = {
  spotId: string;
  success: boolean;
  note?: string;
};

// ----- Schema -----

const typeDefs = readFileSync(join(process.cwd(), 'schema.graphql'), 'utf8');

// ----- Helper: Map DB row → GraphQL Spot -----

function mapSpot(row: SpotRow) {
  return {
    id: row.id,
    name: row.name,
    latitude: row.latitude,
    longitude: row.longitude,
    bundesland: row.bundesland,
    gewaesserTyp: row.gewaesser_typ,
    fishSpecies: row.fischarten,
    avgCrowdLevel: row.avg_crowd_level,
  };
}

// ----- Resolvers -----

const resolvers = {
  Query: {
    health: async () => {
      const mlOk = await checkMLHealth();
      return { status: mlOk ? 'ok' : 'degraded (ML service unavailable)' };
    },

    spots: async (_: unknown, args: { bundesland?: string; fishSpecies?: string }) => {
      const db = getSupabase();
      let query = db.from('spots').select('*');

      if (args.bundesland) {
        query = query.eq('bundesland', args.bundesland);
      }
      if (args.fishSpecies) {
        query = query.contains('fischarten', JSON.stringify([args.fishSpecies]));
      }

      const { data, error } = await query.order('name');
      if (error) throw new Error(`DB error: ${error.message}`);

      return (data as SpotRow[]).map(mapSpot);
    },

    spot: async (_: unknown, args: { id: string }) => {
      const db = getSupabase();
      const { data, error } = await db.from('spots').select('*').eq('id', args.id).single();
      if (error) return null;
      return data ? mapSpot(data as SpotRow) : null;
    },

    recommendations: async (_: unknown, args: { input: RecommendationInput }) => {
      const { input } = args;
      const db = getSupabase();

      // 1. Fetch spots, filtered by bundesland if provided
      let query = db.from('spots').select('*');
      if (input.bundesland) {
        query = query.eq('bundesland', input.bundesland);
      }
      const { data: spots, error } = await query;
      if (error) throw new Error(`DB error: ${error.message}`);
      if (!spots || spots.length === 0) {
        throw new Error('Keine Angelstellen in der Datenbank gefunden.');
      }

      // 2. Get ML prediction
      let biteProbability: number;
      try {
        const mlResult = await predictBiteProbability({
          target_species: input.targetSpecies,
          water_temp_c: input.waterTempC,
          wind_kmh: input.windKmh,
          pressure_hpa: input.pressureHpa,
          moon_phase: input.moonPhase,
          season: input.season,
        });
        biteProbability = mlResult.bite_probability;
      } catch {
        // Fallback: compute basic score locally if ML service is down
        const tempBonus = Math.max(0, 18 - Math.abs(input.waterTempC - 14)) * 1.8;
        const windPenalty = Math.max(0, input.windKmh - 18) * 1.0;
        const pressureBonus = Math.max(0, 20 - Math.abs(input.pressureHpa - 1015)) * 0.7;
        biteProbability = Math.max(5, Math.min(95, 40 + tempBonus - windPenalty + pressureBonus));
      }

      // 3. Multi-factor ranking
      const ranked = rankSpots(
        spots as SpotRow[],
        biteProbability,
        input.targetSpecies,
        input.season,
        3
      );

      return ranked.map((r) => ({
        spot: mapSpot(r.spot),
        score: r.score,
        breakdown: r.breakdown,
        reason: r.reason,
        bestWindow: r.bestWindow,
      }));
    },
  },

  Mutation: {
    submitFeedback: async (_: unknown, args: { input: FeedbackInput }) => {
      const db = getSupabase();
      const { input } = args;

      const { error } = await db.from('feedback').insert({
        spot_id: input.spotId,
        success: input.success,
        note: input.note ?? null,
        user_id: null,  // Anonymous feedback allowed; auth users set via RLS context
      });

      if (error) throw new Error(`Feedback error: ${error.message}`);
      return true;
    },
  },
};

// ----- Server Start -----

const server = new ApolloServer({ typeDefs, resolvers });

startStandaloneServer(server, {
  listen: { port: Number(process.env.PORT ?? 4000) },
}).then(({ url }) => {
  console.log(`GraphQL API ready at ${url}`);
});
