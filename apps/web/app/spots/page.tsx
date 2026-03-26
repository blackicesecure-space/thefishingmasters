"use client";

import { useState } from "react";
import { useQuery } from "@apollo/client";
import { SPOTS_QUERY } from "@/lib/graphql/queries";
import { BUNDESLAENDER } from "@/lib/constants";
import { displayBundesland } from "@/lib/format";
import Link from "next/link";

interface Spot {
  id: string;
  name: string;
  bundesland: string;
  gewaesserTyp: string;
  fishSpecies: string[];
  avgCrowdLevel: number;
}

export default function SpotsPage() {
  const [bundesland, setBundesland] = useState("");
  const [search, setSearch] = useState("");

  const { data, loading, error } = useQuery(SPOTS_QUERY, {
    variables: bundesland ? { bundesland } : {},
  });

  const spots: Spot[] = data?.spots ?? [];
  const filtered = search
    ? spots.filter(
        (s) =>
          s.name.toLowerCase().includes(search.toLowerCase()) ||
          s.fishSpecies.some((f) =>
            f.toLowerCase().includes(search.toLowerCase())
          )
      )
    : spots;

  return (
    <div>
      <h1 className="text-2xl font-bold mb-2">Angelstellen</h1>
      <p className="text-text-muted text-sm mb-6">
        {spots.length} Spots in Mitteldeutschland
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
      </div>

      {/* Error */}
      {error && (
        <div className="bg-error/10 border border-error/30 text-error rounded-card p-4 mb-6">
          Fehler: {error.message}
        </div>
      )}

      {/* Loading */}
      {loading && (
        <div className="flex justify-center py-12">
          <div className="text-text-muted">Lade Spots...</div>
        </div>
      )}

      {/* Results */}
      {!loading && (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
          {filtered.map((spot) => (
            <Link
              key={spot.id}
              href={`/spots/${spot.id}`}
              className="card border border-border hover:border-accent/40 transition-colors group"
            >
              <h3 className="font-bold group-hover:text-accent transition-colors">
                {spot.name}
              </h3>
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
                    className={`w-2.5 h-2.5 rounded-full ${
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
        <div className="card text-center py-12">
          <p className="text-text-muted">
            Keine Spots gefunden. Versuche einen anderen Filter.
          </p>
        </div>
      )}
    </div>
  );
}
