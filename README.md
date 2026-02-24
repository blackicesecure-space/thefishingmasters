# The Fishing Masters

AI-gestützte Angel-Empfehlungsplattform für Mitteldeutschland.

## Vision
Wir bauen eine datengetriebene App, die Anglern täglich sagt, **wohin** sie fahren sollten – mit nachvollziehbarer Beißprognose, Spot-Ranking und Community-Feedback.

## Zielarchitektur (MVP)
- **Frontend:** React Native (Expo), Next.js (Web), TypeScript, Tailwind CSS, Mapbox GL JS
- **Backend:** Supabase (PostgreSQL/Auth/Realtime), GraphQL API (Apollo auf Vercel Serverless), Python FastAPI
- **ML/Data:** Python 3.11, scikit-learn, pandas, numpy, pdfplumber

## Repository-Struktur
- `apps/web`: Web-MVP Scope + Akzeptanzkriterien
- `apps/mobile`: Mobile-MVP Scope
- `services/api`: GraphQL Schema + Server-Bootstrap
- `services/ml`: FastAPI-Startservice (`/health`, `/predict`) + Scoring-Modul
- `infra/supabase`: Datenbankschema & Migrationen
- `data_pipeline`: PDF-Extraktion für LAV-Daten
- `tests`: Unit-Tests für ML-Scoring und PDF-Parser
- `files/index.html`: frühes UI-Prototyping

## Status (Go-Forward)
- ✅ Monorepo-Tooling (pnpm + Turbo) etabliert
- ✅ Supabase-Migration bereitgestellt (`infra/supabase/migrations/001_init.sql`)
- ✅ GraphQL-Schema + Resolver-Bootstrap vorhanden (`services/api`)
- ✅ FastAPI-Service mit `/predict` und `/health` vorhanden (`services/ml/app.py`)
- ✅ Datenimport-Pipeline Startpunkt vorhanden (`data_pipeline/import_lav_pdf.py`)
- ✅ Baseline-Unit-Tests vorhanden (`tests/test_scoring.py`, `tests/test_data_pipeline.py`)

## Readme-Index (pro Bereich)
- Architektur: `docs/system-architecture.md`
- Web: `apps/web/README.md`
- Mobile: `apps/mobile/README.md`
- API: `services/api/README.md`
- ML: `services/ml/README.md`
- Data Pipeline: `data_pipeline/README.md`

## Quickstart
### 1) ML API starten
```bash
cd services/ml
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app:app --reload --port 8001
```

### 2) GraphQL API starten
```bash
cd services/api
pnpm install
pnpm dev
```

### 3) Unit-Tests ausführen
```bash
cd /workspace/thefishingmasters
python3 -m unittest discover -s tests -p 'test_*.py'
```


## Merge- & Branch-Hinweis
- Bei Merge-Konflikten gilt diese Struktur als Referenz für README-Inhalte.
- Detailentscheidungen leben in den jeweiligen Bereichs-READMEs (Web/Mobile/API/ML/Data).
