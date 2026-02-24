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

## Nächste technische TODOs
1. Monorepo-Tooling (pnpm + Turbo/Nx) etablieren
2. Supabase-Projekt initialisieren und `infra/supabase/schema.sql` migrieren
3. GraphQL-Schema (Auth, Spot-Query, Prediction-Resolver) aufsetzen
4. FastAPI-Service mit `/predict` und `/health` bereitstellen
5. Datenimport-Pipeline für LAV-PDFs erstellen

> Hinweis: Der aktuelle Umsetzungsstand dieser Punkte ist im Abschnitt **Status (Go-Forward)** dokumentiert.

## Status (Go-Forward)
- ✅ Monorepo-Tooling (pnpm + Turbo/Nx) etabliert
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
**macOS/Linux (bash/zsh)**
```bash
cd services/ml
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app:app --reload --port 8001
```

**Windows (PowerShell)**
```powershell
Set-Location services/ml
py -m venv .venv
.\.venv\Scripts\Activate.ps1
py -m pip install -r .\requirements.txt
py -m uvicorn app:app --reload --port 8001
```

### 2) GraphQL API starten
**Empfohlen (Repo-Root, Turbo Workspace):**
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

### 3) Unit-Tests ausführen
**macOS/Linux (bash/zsh)**
```bash
cd /workspace/thefishingmasters
python3 -m unittest discover -s tests -t . -p 'test_*.py'
```

**Windows (PowerShell)**
```powershell
Set-Location <REPO_ROOT>
py -m unittest discover -s tests -t . -p "test_*.py"
```

### 4) Optional: ML API vom Repo-Root starten
```bash
uvicorn services.ml.app:app --reload --port 8001
```

## Merge- & Branch-Hinweis
- Bei Merge-Konflikten gilt diese Struktur als Referenz für README-Inhalte.
- Detailentscheidungen leben in den jeweiligen Bereichs-READMEs (Web/Mobile/API/ML/Data).


### Test-Discovery Troubleshooting (Windows/py launcher)
Wenn `ImportError: Start directory is not importable: 'tests'` erscheint, stelle sicher, dass du im Repo-Root bist und nutze:

```powershell
Set-Location <REPO_ROOT>
py -m unittest discover -s tests -t . -p "test_*.py"
```

Wenn `requirements.txt` im `services/ml`-Ordner nicht gefunden wird, warst du sehr wahrscheinlich im falschen Verzeichnis. Prüfe zuerst mit `Get-Location` und installiere alternativ direkt vom Repo-Root:

```powershell
Set-Location <REPO_ROOT>
py -m pip install -r .\services\ml\requirements.txt
```


## Konfliktauflösung (Canonical Sections)
- Root-Quickstart und Troubleshooting in dieser Datei sind die führende Referenz.
- Bereichsdetails stehen in den jeweiligen Service-READMEs, widersprechen aber nicht den Root-Kommandos.

