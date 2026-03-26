"use client";

import { useQuery } from "@apollo/client";
import { SPOTS_QUERY } from "@/lib/graphql/queries";
import { useParams } from "next/navigation";
import Link from "next/link";

export default function SpotDetailPage() {
  const params = useParams();
  const spotId = params.id as string;

  const { data, loading, error } = useQuery(SPOTS_QUERY);

  if (loading) {
    return (
      <div className="flex justify-center py-20">
        <div className="text-text-muted">Lade Spot-Daten...</div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="card text-center py-12">
        <p className="text-error mb-4">Fehler beim Laden: {error.message}</p>
        <Link href="/flow" className="btn-secondary">
          Zurück zur Empfehlung
        </Link>
      </div>
    );
  }

  const spot = data?.spots?.find(
    (s: { id: string }) => s.id === spotId
  );

  if (!spot) {
    return (
      <div className="card text-center py-12">
        <p className="text-text-muted mb-4">Spot nicht gefunden.</p>
        <Link href="/flow" className="btn-secondary">
          Zurück zur Empfehlung
        </Link>
      </div>
    );
  }

  const mapsUrl = `https://www.google.com/maps/search/?api=1&query=${spot.latitude},${spot.longitude}`;

  return (
    <div className="max-w-2xl mx-auto">
      {/* Header */}
      <div className="mb-6">
        <Link
          href="/flow"
          className="text-sm text-text-muted hover:text-accent mb-2 inline-block"
        >
          ← Zurück
        </Link>
        <h1 className="text-3xl font-bold">{spot.name}</h1>
        <p className="text-text-muted">
          {spot.gewaesserTyp} &middot;{" "}
          {spot.bundesland === "Thueringen" ? "Thüringen" : spot.bundesland}
        </p>
      </div>

      {/* Info Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-6">
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

      {/* Location */}
      <div className="card mb-6">
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

      {/* Actions */}
      <div className="flex gap-3">
        <Link href="/flow" className="btn-primary flex-1 text-center">
          Empfehlung für diesen Spot
        </Link>
        <Link href="/feedback" className="btn-secondary flex-1 text-center">
          Feedback geben
        </Link>
      </div>
    </div>
  );
}
