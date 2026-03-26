import { readFileSync } from 'node:fs';
import { join } from 'node:path';
import { ApolloServer } from '@apollo/server';
import { startStandaloneServer } from '@apollo/server/standalone';
import { getSupabase, type SpotRow } from './db/supabase.js';
import {
  predictBiteProbability,
  checkMLHealth,
  fetchWeather,
  fetchLunar,
  type MLWeatherResponse,
  type MLLunarResponse,
} from './services/ml-client.js';
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
  targetSpecies?: string;
  crowdLevel?: number;
};

// ----- Lure data (mirrors species_rules.py) -----

const SPECIES_LURES: Record<string, { lures: string[]; tactics: string[] }> = {
  Zander: { lures: ['Gummifisch 10-15cm', 'Wobbler (Suspender)', 'Köderfisch am System'], tactics: ['Faulenzen', 'Jiggen am Grund'] },
  Hecht: { lures: ['Gummifisch 15-25cm', 'Jerkbait', 'Spinner 4-5'], tactics: ['Spinnfischen', 'Deadbait am Grund'] },
  Barsch: { lures: ['Drop-Shot Wurm', 'Gummifisch 5-8cm', 'Spinner 1-3'], tactics: ['Drop-Shot', 'Ultra-Light Spinnfischen'] },
  Karpfen: { lures: ['Boilie 15-20mm', 'Mais', 'Tigernuss'], tactics: ['Grundangeln mit Haar-Rig', 'Method Feeder'] },
  Aal: { lures: ['Tauwurm', 'Köderfisch (klein)', 'Wurmbündel'], tactics: ['Grundangeln', 'Legangeln'] },
  Forelle: { lures: ['Spinner 1-2', 'Wobbler 3-5cm', 'Kunstfliege'], tactics: ['Spinnfischen', 'Fliegenfischen'] },
  Wels: { lures: ['Köderfisch gross', 'Tauwurmbündel', 'Pellet'], tactics: ['Grundangeln', 'Klopfen/Wallerangeln'] },
  Schleie: { lures: ['Made', 'Mais', 'Wurm'], tactics: ['Posenangeln', 'Method Feeder'] },
  Barbe: { lures: ['Käse-Würfel', 'Frühstücksfleisch', 'Made'], tactics: ['Feederangeln', 'Posenangeln'] },
  Rapfen: { lures: ['Blinker silber', 'Wobbler (Topwater)', 'Spinner 3-4'], tactics: ['Spinnfischen Oberfläche', 'Speed-Spinning'] },
  'Döbel': { lures: ['Brot', 'Kirsche', 'Spinner klein'], tactics: ['Oberflächenangeln', 'Spinnfischen'] },
  'Köderfisch': { lures: ['Made', 'Wurm (klein)', 'Brot'], tactics: ['Stippen', 'Posenangeln flach'] },
  Rotauge: { lures: ['Made', 'Wurm (klein)', 'Mais'], tactics: ['Posenangeln', 'Feederangeln'] },
  Rotfeder: { lures: ['Brot', 'Made', 'Teig'], tactics: ['Oberflächenangeln', 'Posenangeln flach'] },
  Ukelei: { lures: ['Made (einzeln)', 'Brotflocke', 'Mini-Teig'], tactics: ['Stippen Oberfläche', 'Posenangeln flach'] },
  'Gründling': { lures: ['Wurm (klein)', 'Made', 'Mistwurm'], tactics: ['Posenangeln Grund', 'Leichte Grundmontage'] },
  'Güster': { lures: ['Made', 'Wurm', 'Mais'], tactics: ['Feederangeln', 'Posenangeln'] },
};

function getLureRecommendation(species: string): { lures: string[]; tactics: string[] } {
  return SPECIES_LURES[species] ?? { lures: ['Universalköder'], tactics: ['Grundangeln'] };
}

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
    flaecheHa: row.flaeche_ha,
    maxTiefeM: row.max_tiefe_m,
    parkplatz: row.parkplatz,
    beschreibung: row.beschreibung,
  };
}

function mapWeather(w: MLWeatherResponse) {
  return {
    tempCelsius: w.temp_celsius,
    windSpeedKmh: w.wind_speed_kmh,
    windDirection: w.wind_direction,
    pressureHpa: w.pressure_hpa,
    cloudCover: w.cloud_cover,
    humidity: w.humidity,
    precipitationMm: w.precipitation_mm,
    description: w.description,
    icon: w.icon,
  };
}

function mapLunar(l: MLLunarResponse) {
  return {
    date: l.date,
    moonPhasePct: l.moon_phase_pct,
    moonPhaseName: l.moon_phase_name,
    moonIllumination: l.moon_illumination,
    solunarMajor1: l.solunar_major_1,
    solunarMajor2: l.solunar_major_2,
    solunarMinor1: l.solunar_minor_1,
    solunarMinor2: l.solunar_minor_2,
    solunarRating: l.solunar_rating,
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

      const lure = getLureRecommendation(input.targetSpecies);

      return ranked.map((r) => ({
        spot: mapSpot(r.spot),
        score: r.score,
        breakdown: r.breakdown,
        reason: r.reason,
        bestWindow: r.bestWindow,
        lure,
      }));
    },

    weather: async (_: unknown, args: { lat: number; lon: number }) => {
      try {
        const data = await fetchWeather(args.lat, args.lon);
        return mapWeather(data);
      } catch {
        // Fallback weather
        return {
          tempCelsius: 14.0,
          windSpeedKmh: 10.0,
          windDirection: 0,
          pressureHpa: 1013.0,
          cloudCover: 50,
          humidity: 65,
          precipitationMm: 0,
          description: 'Keine Wetterdaten verfügbar',
          icon: '03d',
        };
      }
    },

    lunar: async (_: unknown, args: { date?: string; lat?: number; lon?: number }) => {
      try {
        const data = await fetchLunar(args.date ?? undefined, args.lat ?? 51.3, args.lon ?? 12.0);
        return mapLunar(data);
      } catch {
        // Fallback lunar data
        return {
          date: new Date().toISOString().split('T')[0],
          moonPhasePct: 50,
          moonPhaseName: 'Nicht verfügbar',
          moonIllumination: 50,
          solunarMajor1: '06:00-08:00',
          solunarMajor2: '18:00-20:00',
          solunarMinor1: '12:00-13:00',
          solunarMinor2: '00:00-01:00',
          solunarRating: 3,
        };
      }
    },

    dashboard: async () => {
      const db = getSupabase();

      // Aggregate stats from ALL feedback rows
      const { data: allFeedback, error: allError } = await db
        .from('feedback')
        .select('success');

      if (allError) throw new Error(`DB error: ${allError.message}`);

      const all = allFeedback ?? [];
      const successCount = all.filter((f) => f.success).length;
      const failCount = all.filter((f) => !f.success).length;
      const total = successCount + failCount;

      // Recent feedback limited to 10 for display
      const { data: recent, error: recentError } = await db
        .from('feedback')
        .select('id, spot_id, success, note, created_at')
        .order('created_at', { ascending: false })
        .limit(10);

      if (recentError) throw new Error(`DB error: ${recentError.message}`);

      return {
        totalSessions: total,
        successCount,
        failCount,
        hitRate: total > 0 ? Math.round((successCount / total) * 100) : 0,
        recentFeedback: (recent ?? []).map((f) => ({
          id: f.id,
          spotId: f.spot_id,
          success: f.success,
          note: f.note,
          createdAt: f.created_at,
        })),
      };
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
        target_species: input.targetSpecies ?? null,
        crowd_level: input.crowdLevel ?? null,
        user_id: null,
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
