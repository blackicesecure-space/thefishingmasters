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
Siehe vollständige Spezifikation in `docs/system-architecture.md`.

## Repository-Struktur
- `apps/web`: Next.js Web-App (Platzhalterstruktur)
- `apps/mobile`: Expo React-Native-App (Platzhalterstruktur)
- `services/api`: GraphQL API (Serverless, Platzhalter)
- `services/ml`: FastAPI Prediction Service (Platzhalter)
- `infra/supabase`: Datenbankschema & Seed-Richtung
- `files/index.html`: frühes UI-Prototyping

## Nächste technische TODOs
1. Monorepo-Tooling (pnpm + Turbo/Nx) etablieren
2. Supabase-Projekt initialisieren und `infra/supabase/schema.sql` migrieren
3. GraphQL-Schema (Auth, Spot-Query, Prediction-Resolver) aufsetzen
4. FastAPI-Service mit `/predict` und `/health` bereitstellen
5. Datenimport-Pipeline für LAV-PDFs erstellen

