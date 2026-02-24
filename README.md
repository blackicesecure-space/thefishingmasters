# The Fishing Masters

AI-gestützte Angel-Empfehlungsplattform für Mitteldeutschland.

## Vision
Wir bauen eine datengetriebene App, die Anglern täglich sagt, **wohin** sie fahren sollten – mit nachvollziehbarer Beißprognose, Spot-Ranking und Community-Feedback.

## Zielarchitektur (MVP)
- **Frontend:** React Native (Expo), Next.js (Web), TypeScript, Tailwind CSS, Mapbox GL JS
- **Backend:** Supabase (PostgreSQL/Auth/Realtime), GraphQL API (Apollo auf Vercel Serverless), Python FastAPI
- **ML/Data:** Python 3.11, scikit-learn, pandas, numpy, pdfplumber

## Repository-Struktur
- `apps/web`: Next.js Web-App (Platzhalterstruktur)
- `apps/mobile`: Expo React-Native-App (Platzhalterstruktur)
- `services/api`: GraphQL Schema + Server-Bootstrap
- `services/ml`: FastAPI-Startservice (`/health`, `/predict`)
- `infra/supabase`: Datenbankschema & Migrationen
- `data_pipeline`: PDF-Extraktion für LAV-Daten
- `files/index.html`: frühes UI-Prototyping

## Architektur-Dokument (Soll + Ist)
- Zielarchitektur und aktueller Umsetzungsstand sind in `docs/system-architecture.md` als **Soll + Ist** strukturiert dokumentiert.
- Die Roadmap mit den nächsten Schritten ist dort unter **Roadmap / Nächste Schritte** gepflegt.

## Nächste technische TODOs (Status)
- ✅ Monorepo-Tooling (pnpm + Turbo) etabliert
- ✅ Supabase-Migration als SQL-Datei bereitgestellt (`infra/supabase/migrations/001_init.sql`)
- ✅ GraphQL-Schema + Resolver-Bootstrap vorhanden (`services/api`)
- ✅ FastAPI-Service mit `/predict` und `/health` vorhanden (`services/ml/app.py`)
- ✅ Datenimport-Pipeline Startpunkt vorhanden (`data_pipeline/import_lav_pdf.py`)

## Quickstart
### ML API
```bash
cd services/ml
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app:app --reload --port 8001
```

### GraphQL API
```bash
cd services/api
pnpm install
pnpm dev
```
