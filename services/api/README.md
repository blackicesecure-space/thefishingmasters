# GraphQL API (Vercel Serverless)

## MVP-Scope
- Auth-geschützte Spot-Suche/Filter
- Empfehlung-Query mit ML-Bridge
- Feedback-Mutation (Erfolg/Misserfolg)

## Aktueller Stand
- `schema.graphql`: schema-first Startpunkt
- `src/server.ts`: Apollo Standalone Bootstrap mit Mock-Resolvern
- ML-Bridge in `Query.recommendations` via `/predict`

## Lokal starten
```bash
cd services/api
pnpm install
pnpm dev
```

## Geplanter Resolver-Flow
1. `Query.spots`: liest Spotdaten aus Supabase.
2. `Query.recommendations`: ruft ML-Service `/predict` auf und rankt Ergebnisse.
3. `Mutation.submitFeedback`: schreibt Session-/Outcome-Daten in Supabase.

## Next Steps
- Auth-Context in Resolvern ergänzen
- Mockdaten durch Supabase-Queries ersetzen
- Fehlerhandling + Retries für ML-Bridge verbessern
