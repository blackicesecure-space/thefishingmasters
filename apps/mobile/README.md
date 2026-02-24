# Mobile App (Expo + React Native)

## Geplante Features (MVP)
Geplante Features (MVP):
- GPS-Lokalisierung
- Mapbox-Map mit Spot-Layern
- Push-Benachrichtigungen
- Offline Mode

## Kern-Screens (MVP)
- Home / Empfehlung starten
- Kartenansicht (Spots + Distanz)
- Spot-Detail
- Session-Feedback
- Profil / Einstellungen

## API-Integration (MVP)
- `Query.spots` für Karten- und Listendarstellung
- `Query.recommendations` für Top-3 Vorschläge
- `Mutation.submitFeedback` für Erfolg/Misserfolg

## Nächste Implementierungsschritte
1. Expo-App initialisieren (TypeScript Template)
2. Standortfreigabe + GPS Hook integrieren
3. Mapbox-Basislayer + Spot-Marker anbinden
4. Recommendation-Flow mit API verbinden
5. Feedback-Submit + Offline Queue umsetzen


## Akzeptanzkriterien (MVP)
- Empfehlung kann aus der App gestartet und angezeigt werden.
- Spot-Detail ist aus Karte und Liste erreichbar.
- Feedback kann offline gepuffert und später synchronisiert werden.
