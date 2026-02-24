import { readFileSync } from 'node:fs';
import { join } from 'node:path';
import { ApolloServer } from '@apollo/server';
import { startStandaloneServer } from '@apollo/server/standalone';

type RecommendationInput = {
  targetSpecies: string;
  waterTempC: number;
  windKmh: number;
  pressureHpa: number;
  moonPhase: number;
  season: string;
};

const typeDefs = readFileSync(join(process.cwd(), 'schema.graphql'), 'utf8');

const mockSpots = [
  {
    id: '1',
    name: 'Goitzschesee',
    latitude: 51.624,
    longitude: 12.346,
    bundesland: 'Sachsen-Anhalt',
    gewaesserTyp: 'See',
    fishSpecies: ['Zander', 'Barsch'],
    avgCrowdLevel: 3
  }
];

const resolvers = {
  Query: {
    health: () => ({ status: 'ok' }),
    spots: (_: unknown, args: { bundesland?: string; fishSpecies?: string }) => {
      return mockSpots.filter((spot) => {
        const stateOk = args.bundesland ? spot.bundesland === args.bundesland : true;
        const fishOk = args.fishSpecies ? spot.fishSpecies.includes(args.fishSpecies) : true;
        return stateOk && fishOk;
      });
    },
    recommendations: async (_: unknown, args: { input: RecommendationInput }) => {
      const mlApiBase = process.env.ML_API_BASE_URL ?? 'http://127.0.0.1:8001';
      const response = await fetch(`${mlApiBase}/predict`, {
        method: 'POST',
        headers: { 'content-type': 'application/json' },
        body: JSON.stringify({
          target_species: args.input.targetSpecies,
          water_temp_c: args.input.waterTempC,
          wind_kmh: args.input.windKmh,
          pressure_hpa: args.input.pressureHpa,
          moon_phase: args.input.moonPhase,
          season: args.input.season
        })
      });

      if (!response.ok) {
        throw new Error(`ML API request failed: ${response.status}`);
      }

      const payload = (await response.json()) as { bite_probability: number };
      return mockSpots.map((spot) => ({
        spot,
        score: payload.bite_probability,
        reason: 'Baseline score from ML /predict endpoint',
        bestWindow: '16:00-19:00'
      }));
    }
  },
  Mutation: {
    submitFeedback: () => true
  }
};

const server = new ApolloServer({ typeDefs, resolvers });

startStandaloneServer(server, { listen: { port: Number(process.env.PORT ?? 4000) } }).then(({ url }) => {
  console.log(`GraphQL API ready at ${url}`);
});
