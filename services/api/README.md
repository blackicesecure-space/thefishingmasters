# GraphQL API (Vercel Serverless)

MVP-Scope:
- Auth-geschützte Spot-Suche/Filter
- Empfehlung-Query mit ML-Bridge
- Feedback-Mutation (Erfolg/Misserfolg)

## Artefakte
- `schema.graphql`: schema-first Startpunkt für Apollo Server.

## Geplanter Resolver-Flow
1. `Query.spots`: liest Spotdaten aus Supabase.
2. `Query.recommendations`: ruft ML-Service `/predict` auf und rankt Ergebnisse.
3. `Mutation.submitFeedback`: schreibt Session-/Outcome-Daten in Supabase.
