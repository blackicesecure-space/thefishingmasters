# Web App (Next.js + TypeScript)

## Geplante Features (MVP)
- 3-Schritt User Flow: Ziel → Constraints → Empfehlung
- Spot-Detailseite
- Feedback-Flow
- Dashboard

## Feature-Scope (konkret)

### 1) 3-Schritt User Flow
#### Ziel
- Nutzer wählt Zielfisch, Region/Bundesland, Tageszeit.

#### Constraints
- Nutzer setzt Rahmenbedingungen (Wind, Temperatur, verfügbare Fahrtzeit, Angelstil).

#### Empfehlung
- Top-3 Spots mit Score, Begründung, Zeitfenster und Köder-Hinweis.

#### Akzeptanzkriterien
- Nutzer kann den Flow ohne Seitenreload durchlaufen.
- Pflichtfelder werden validiert, Fehler sind klar sichtbar.
- Ergebnisansicht zeigt immer genau 3 Empfehlungen mit nachvollziehbarer Begründung.

### 2) Spot-Detailseite
- Vollständige Spot-Metadaten (Gewässertyp, Fischarten, Regeln/Schonzeiten).
- Karte + Koordinaten.
- Aktuelle Kontextdaten (Wetter/Lunar/Crowd, sobald integriert).

#### Akzeptanzkriterien
- Seite ist direkt über URL (`/spots/[id]`) aufrufbar.
- Fehlender Spot führt auf eine definierte Not-Found-Ansicht.
- Basisdaten werden aus API geladen und sauber formatiert dargestellt.

### 3) Feedback-Flow
- Erfolg/Misserfolg je Session erfassen.
- Optionaler Kommentar + später Foto-Upload.
- Speicherung via API-Mutation (`submitFeedback`).

#### Akzeptanzkriterien
- Feedback kann pro Recommendation-Session genau einmal abgeschickt werden.
- Erfolg/Misserfolg wird mit Zeitstempel gespeichert.
- Submit-Status (loading/success/error) wird sichtbar angezeigt.

### 4) Dashboard
- Letzte Empfehlungen und Feedback-Historie.
- Persönliche Trefferquote (rolling 30 Tage).
- Quick-Actions für neue Session und Lieblingsspots.

#### Akzeptanzkriterien
- Dashboard zeigt mindestens die letzten 10 Sessions.
- Trefferquote wird aus echten Session-/Feedback-Daten berechnet.
- Navigation zu Flow und Spot-Details ist in 1 Klick möglich.

## MVP-Seitenstruktur (Vorschlag)
- `/` → Einstieg / Start eines neuen Flows
- `/flow` → 3-Schritt Empfehlung
- `/spots/[id]` → Spot-Detailseite
- `/dashboard` → persönliche Übersicht

## API-Mapping (MVP)
- `Query.spots` → Spot-Suche, Liste, Detaildaten
- `Query.recommendations` → Top-3 Empfehlungen inkl. Score + Reason
- `Mutation.submitFeedback` → Erfolg/Misserfolg je Session speichern

## Priorisierung (Build Order)
1. Flow (`/flow`) + `Query.recommendations`
2. Spot-Detailseite (`/spots/[id]`) + `Query.spots`
3. Feedback-Flow + `Mutation.submitFeedback`
4. Dashboard-Aggregationen

## Nächste Implementierungsschritte
1. Next.js-App initialisieren (`app/` Router, TypeScript, Tailwind).
2. UI-States und Formularschema für den 3-Schritt Flow definieren.
3. GraphQL-Client anbinden (`Query.spots`, `Query.recommendations`).
4. Feedback-Submit gegen `Mutation.submitFeedback` integrieren.
5. Dashboard-KPIs aus Session-/Feedback-Daten ableiten.

## Definition of Done (MVP)
- Flow, Spot-Detail, Feedback und Dashboard sind routbar und manuell testbar.
- GraphQL-Queries/Mutations sind angebunden und Fehlermeldungen werden angezeigt.
- Grundlegende Smoke-Checks für Kernpfade sind dokumentiert.

## Merge-Hinweis
- Diese Datei enthält Web-Scope/DoD.
- Workspace-Start und plattformübergreifende Kommandos kommen zentral aus dem Root-README.md.
