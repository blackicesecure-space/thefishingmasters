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
**Empfohlen (Repo-Root):**
```bash
pnpm install
pnpm dev --filter api
```

**Direkt im Service-Ordner:**
```bash
cd services/api
pnpm install
pnpm dev
```

**Windows (PowerShell):**
```powershell
Set-Location <REPO_ROOT>
pnpm install
pnpm dev --filter api
```

## Geplanter Resolver-Flow
1. `Query.spots`: liest Spotdaten aus Supabase.
2. `Query.recommendations`: ruft ML-Service `/predict` auf und rankt Ergebnisse.
3. `Mutation.submitFeedback`: schreibt Session-/Outcome-Daten in Supabase.

## Next Steps
- Auth-Context in Resolvern ergänzen
- Mockdaten durch Supabase-Queries ersetzen
- Fehlerhandling + Retries für ML-Bridge verbessern


## Konfiguration
- `ML_API_BASE_URL` (optional, Default: `http://127.0.0.1:8001`)


## Troubleshooting (Windows)
- Fehler `ENOENT ... package.json` bedeutet: aktuelles Verzeichnis enthält keine `package.json` (falscher Ordner oder alter Checkout).
- Prüfen mit `Get-Location` und `Get-ChildItem .\package.json`.
- Falls Datei fehlt: `Set-Location <REPO_ROOT>` und `git pull`, dann erneut `pnpm install` + `pnpm dev --filter api`.
