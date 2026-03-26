"use client";

import { useState } from "react";
import { useQuery } from "@apollo/client";
import { SPOTS_QUERY } from "@/lib/graphql/queries";
import { BUNDESLAENDER } from "@/lib/constants";
import { displayBundesland } from "@/lib/format";
import LoadingSpinner from "@/components/ui/LoadingSpinner";
import Link from "next/link";

interface Spot {
  id: string;
  name: string;
  bundesland: string;
  gewaesserTyp: string;
  fishSpecies: string[];
  avgCrowdLevel: number;
}

const WATER_TYPE_EMOJI: Record<string, string> = {
  See: "🏞️",
  Fluss: "🌊",
  Talsperre: "🏔️",
  Teich: "🪷",
  Kanal: "🚢",
  Stausee: "🏔️",
  Bach: "💧",
  Graben: "💧",
};

export default function SpotsPage() {
  const [bundesland, setBundesland] = useState("");
  const [search, setSearch] = useState("");
  const [waterType, setWaterType] = useState("");

  const { data, loading, error } = useQuery(SPOTS_QUERY, {
    variables: bundesland ? { bundesland } : {},
  });

  const spots: Spot[] = data?.spots ?? [];
  const filtered = spots.filter((s) => {
    if (search) {
      const q = search.toLowerCase();
      const matchesName = s.name.toLowerCase().includes(q);
      const matchesFish = s.fishSpecies.some((f) => f.toLowerCase().includes(q));
      if (!matchesName && !matchesFish) return false;
    }
    if (waterType && s.gewaesserTyp !== waterType) return false;
    return true;
  });

  const waterTypes = [...new Set(spots.map((s) => s.gewaesserTyp))].sort();

  return (
    <div>
      <h1 className="text-2xl font-bold mb-2">Angelstellen</h1>
      <p className="text-text-muted text-sm mb-6">
        {filtered.length} von {spots.length} Spots
        {bundesland ? ` in ${displayBundesland(bundesland)}` : " in Mitteldeutschland"}
      </p>

      {/* Filters */}
      <div className="flex flex-col sm:flex-row gap-3 mb-6">
        <input
          type="text"
          placeholder="Suche nach Name oder Fischart..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          className="input-field flex-1"
        />
        <select
          className="select-field sm:w-48"
          value={bundesland}
          onChange={(e) => setBundesland(e.target.value)}
        >
          <option value="">Alle Bundesländer</option>
          {BUNDESLAENDER.map((b) => (
            <option key={b} value={b}>
              {displayBundesland(b)}
            </option>
          ))}
        </select>
        <select
          className="select-field sm:w-40"
          value={waterType}
          onChange={(e) => setWaterType(e.target.value)}
        >
          <option value="">Alle Gewässer</option>
          {waterTypes.map((t) => (
            <option key={t} value={t}>
              {t}
            </option>
          ))}
        </select>
      </div>

      {error && (
        <div className="bg-error/10 border border-error/30 text-error rounded-card p-4 mb-6">
          Fehler: {error.message}
        </div>
      )}

      {loading && <LoadingSpinner text="Lade Angelstellen..." size="lg" />}

      {!loading && (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 fade-in">
          {filtered.map((spot) => (
            <Link
              key={spot.id}
              href={`/spots/${spot.id}`}
              className="card border border-border hover:border-accent/40 hover:glow-accent transition-all group"
            >
              <div className="flex items-start justify-between mb-1">
                <h3 className="font-bold group-hover:text-accent transition-colors">
                  {spot.name}
                </h3>
                <span className="text-lg" title={spot.gewaesserTyp}>
                  {WATER_TYPE_EMOJI[spot.gewaesserTyp] ?? "🎣"}
                </span>
              </div>
              <p className="text-sm text-text-muted mb-3">
                {spot.gewaesserTyp} &middot; {displayBundesland(spot.bundesland)}
              </p>
              <div className="flex flex-wrap gap-1 mb-2">
                {spot.fishSpecies.slice(0, 4).map((fish) => (
                  <span key={fish} className="badge text-xs">
                    {fish}
                  </span>
                ))}
                {spot.fishSpecies.length > 4 && (
                  <span className="text-xs text-text-muted">
                    +{spot.fishSpecies.length - 4}
                  </span>
                )}
              </div>
              <div className="flex items-center gap-1">
                {[1, 2, 3, 4, 5].map((n) => (
                  <div
                    key={n}
                    className={`w-2.5 h-2.5 rounded-full transition-colors ${
                      n <= spot.avgCrowdLevel ? "bg-warning" : "bg-bg"
                    }`}
                  />
                ))}
                <span className="text-xs text-text-muted ml-1">Andrang</span>
              </div>
            </Link>
          ))}
        </div>
      )}

      {!loading && filtered.length === 0 && (
        <div className="card text-center py-12 fade-in">
          <p className="text-text-muted text-lg mb-2">Keine Spots gefunden</p>
          <p className="text-text-muted text-sm">
            Versuche einen anderen Suchbegriff oder Filter.
          </p>
        </div>
      )}
    </div>
  );
}
