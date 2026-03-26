"use client";

import { useQuery } from "@apollo/client";
import { SPOT_QUERY, WEATHER_QUERY, LUNAR_QUERY } from "@/lib/graphql/queries";
import { useParams } from "next/navigation";
import Link from "next/link";
import { displayBundesland, weatherEmoji, moonEmoji, solunarLabel } from "@/lib/format";

export default function SpotDetailPage() {
  const params = useParams();
  const spotId = params.id as string;

  const { data, loading, error } = useQuery(SPOT_QUERY, {
    variables: { id: spotId },
  });

  const spot = data?.spot;

  // Fetch weather & lunar for this spot's location
  const { data: weatherData } = useQuery(WEATHER_QUERY, {
    variables: { lat: spot?.latitude ?? 51.3, lon: spot?.longitude ?? 12.0 },
    skip: !spot,
  });

  const { data: lunarData } = useQuery(LUNAR_QUERY, {
    variables: { lat: spot?.latitude, lon: spot?.longitude },
    skip: !spot,
  });

  if (loading) {
    return (
      <div className="flex flex-col items-center justify-center gap-3 py-20">
        <div className="w-8 h-8 border-[3px] border-accent/30 border-t-accent rounded-full animate-spin" />
        <div className="text-text-muted">Lade Spot-Daten...</div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="card text-center py-12">
        <p className="text-error mb-4">Fehler beim Laden: {error.message}</p>
        <Link href="/spots" className="btn-secondary">
          Zurück zur Spot-Liste
        </Link>
      </div>
    );
  }

  if (!spot) {
    return (
      <div className="card text-center py-12">
        <p className="text-text-muted mb-4">Spot nicht gefunden.</p>
        <Link href="/spots" className="btn-secondary">
          Zurück zur Spot-Liste
        </Link>
      </div>
    );
  }

  const weather = weatherData?.weather;
  const lunar = lunarData?.lunar;
  const mapsUrl = `https://www.google.com/maps/search/?api=1&query=${spot.latitude},${spot.longitude}`;

  return (
    <div className="max-w-2xl mx-auto fade-in">
      {/* Header */}
      <div className="mb-6">
        <Link
          href="/spots"
          className="text-sm text-text-muted hover:text-accent mb-2 inline-block"
        >
          ← Alle Spots
        </Link>
        <h1 className="text-3xl font-bold">{spot.name}</h1>
        <p className="text-text-muted">
          {spot.gewaesserTyp} &middot; {displayBundesland(spot.bundesland)}
        </p>
      </div>

      {/* Description */}
      {spot.beschreibung && (
        <div className="card mb-4">
          <p className="text-sm text-text">{spot.beschreibung}</p>
        </div>
      )}

      {/* Live Context Cards */}
      {(weather || lunar) && (
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-4">
          {weather && (
            <div className="card">
              <h3 className="text-sm text-text-muted mb-2">Aktuelles Wetter</h3>
              <div className="text-2xl font-bold mb-1">
                {weatherEmoji(weather.icon)} {weather.tempCelsius.toFixed(1)}°C
              </div>
              <div className="text-sm text-text-muted space-y-0.5">
                <p>{weather.description}</p>
                <p>Wind: {weather.windSpeedKmh.toFixed(0)} km/h</p>
                <p>Luftdruck: {weather.pressureHpa.toFixed(0)} hPa</p>
                <p>Bewölkung: {weather.cloudCover}% &middot; Feuchte: {weather.humidity}%</p>
                {weather.precipitationMm > 0 && (
                  <p>Niederschlag: {weather.precipitationMm.toFixed(1)} mm</p>
                )}
              </div>
            </div>
          )}
          {lunar && (
            <div className="card">
              <h3 className="text-sm text-text-muted mb-2">Mond & Solunar</h3>
              <div className="text-2xl font-bold mb-1">
                {moonEmoji(lunar.moonPhasePct)} {lunar.moonPhaseName}
              </div>
              <div className="text-sm text-text-muted space-y-0.5">
                <p>Beleuchtung: {lunar.moonIllumination.toFixed(0)}%</p>
                <p>Solunar-Bewertung: {solunarLabel(lunar.solunarRating)} ({lunar.solunarRating}/5)</p>
                <p>Major: {lunar.solunarMajor1}, {lunar.solunarMajor2}</p>
                <p>Minor: {lunar.solunarMinor1}, {lunar.solunarMinor2}</p>
              </div>
            </div>
          )}
        </div>
      )}

      {/* Info Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-4">
        <div className="card">
          <h3 className="text-sm text-text-muted mb-2">Fischarten</h3>
          <div className="flex flex-wrap gap-1.5">
            {spot.fishSpecies.map((fish: string) => (
              <span key={fish} className="badge">
                {fish}
              </span>
            ))}
          </div>
        </div>

        <div className="card">
          <h3 className="text-sm text-text-muted mb-2">Andrang</h3>
          <div className="flex items-center gap-2">
            {[1, 2, 3, 4, 5].map((n) => (
              <div
                key={n}
                className={`w-4 h-4 rounded-full ${
                  n <= spot.avgCrowdLevel ? "bg-warning" : "bg-bg"
                }`}
              />
            ))}
            <span className="text-sm text-text-muted ml-2">
              {spot.avgCrowdLevel <= 1
                ? "Wenig"
                : spot.avgCrowdLevel <= 3
                ? "Mäßig"
                : "Viel"}{" "}
              Andrang
            </span>
          </div>
        </div>
      </div>

      {/* Spot Details */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-4">
        <div className="card">
          <h3 className="text-sm text-text-muted mb-2">Gewässerinfo</h3>
          <div className="text-sm space-y-1">
            {spot.flaecheHa && <p>Fläche: {spot.flaecheHa} ha</p>}
            {spot.maxTiefeM && <p>Max. Tiefe: {spot.maxTiefeM} m</p>}
            <p>Parkplatz: {spot.parkplatz ? "Ja" : "Nein"}</p>
          </div>
        </div>

        <div className="card">
          <h3 className="text-sm text-text-muted mb-2">Standort</h3>
          <p className="text-sm mb-3">
            {spot.latitude.toFixed(4)}°N, {spot.longitude.toFixed(4)}°E
          </p>
          <a
            href={mapsUrl}
            target="_blank"
            rel="noopener noreferrer"
            className="text-sm text-accent hover:underline"
          >
            In Google Maps öffnen →
          </a>
        </div>
      </div>

      {/* Actions */}
      <div className="flex gap-3">
        <Link href="/flow" className="btn-primary flex-1 text-center">
          Empfehlung starten
        </Link>
        <Link href="/feedback" className="btn-secondary flex-1 text-center">
          Feedback geben
        </Link>
      </div>
    </div>
  );
}
