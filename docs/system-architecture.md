# System-Architektur – The Fishing Masters

## 1) Tech-Stack

### Frontend
- React Native (Expo)
- Next.js (Web)
- TypeScript
- Tailwind CSS
- Mapbox GL JS

### Backend
- Supabase (PostgreSQL + Auth + Realtime)
- Vercel (Serverless)
- GraphQL (Apollo)
- Python FastAPI

### ML/Data
- Python 3.11
- scikit-learn
- pandas, numpy
- pdfplumber

## 2) Architektur-Diagramm (logisch)

```text
USER LAYER
iOS App | Android App | Web App
(React Native / Next.js)
            ↓
API LAYER
GraphQL API (Vercel Serverless)
  - Authentication
  - Spot Queries
  - Predictions
            ↓
EXTERNAL DATA SOURCES
- OpenWeather API
- Astro/Lunar API
- Water Data (DWD / lokal)
            ↓
DATA LAYER
Supabase (PostgreSQL + Auth + Realtime)
  - users
  - spots
  - sessions
            ↓
ML LAYER
Python FastAPI (Railway)
  - Feature Engineering
  - Prediction Engine
  - Spot Ranking
```

## 3) Daten-Foundation

### Initiale Spot-Datenbank
- Ziel: **200 Spots** für MVP in Mitteldeutschland

### Primäre Quellen
- Sachsen-Anhalt: LAV SA Gewässerverzeichnis 2022-2026
- Thüringen: LAVT Gewässerverbund
- Sachsen: LAV Sachsen Gewässerfonds

### SQL-Schema (Startpunkt)
Siehe: `infra/supabase/schema.sql`.

## 4) Echtzeit-Datenquellen
- Wetter: Luftdruck, Wind, Bewölkung, Temperatur
- Lunar: Mondphase, Solunar-Fenster, Mondstand
- Community: Erfolg/Misserfolg, Fangfotos, Crowd-Level

## 5) ML-Prognose-Engine

### Features (MVP)
1. Wetter
2. Lunar
3. Zeit
4. Spot-Metadaten
5. Species-Matching
6. Historische Erfolgsdaten
7. Crowd-Faktor

### Modell
- Random Forest Classifier (MVP-robust, schnell, interpretierbar)
- Zielgenauigkeit initial: **60%+**, danach Iteration mit Realdaten

## 6) Ranking-Strategie

Multi-Objective Score (0–100):
- 40% Beißprognose
- 25% Spot-Qualität
- 15% Convenience
- 15% Crowd-Faktor
- 5% Personalisierung

Output: Top-3-Spots inkl. Zeitfenster, Ködervorschlag, Taktikhinweis.

## 7) Delivery-Plan (MVP, 12 Wochen)
1. Woche 1-2: Data Foundation
2. Woche 3-4: ML Foundation
3. Woche 5-6: Backend
4. Woche 7-9: Frontend Web
5. Woche 10-12: Mobile + QA

## 8) Risiken (Kurz)
- Modellgenauigkeit zu niedrig
- Zu wenig Community-Feedback
- GPS/Geocoding-Qualität
- DSGVO-Compliance

Mitigation: Transparenz, Incentives, Daten-Validierung, Privacy-by-Design.
