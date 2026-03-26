"use client";

import SpotCard from "./SpotCard";
import type { FlowState } from "@/app/flow/page";

interface Breakdown {
  bite: number;
  quality: number;
  convenience: number;
  crowd: number;
  personal: number;
  total: number;
  reasons: string[];
}

interface Recommendation {
  spot: {
    id: string;
    name: string;
    latitude: number;
    longitude: number;
    bundesland: string;
    gewaesserTyp: string;
    fishSpecies: string[];
    avgCrowdLevel: number;
  };
  score: number;
  reason: string;
  bestWindow: string;
  breakdown: Breakdown;
}

interface Props {
  recommendations: Recommendation[];
  state: FlowState;
  onReset: () => void;
}

export default function StepResults({ recommendations, state, onReset }: Props) {
  const seasonLabel: Record<string, string> = {
    Fruehling: "Frühling",
    Sommer: "Sommer",
    Herbst: "Herbst",
    Winter: "Winter",
  };

  return (
    <div>
      <div className="text-center mb-8">
        <h2 className="text-2xl font-bold mb-2">
          Top-3 Empfehlungen für{" "}
          <span className="text-accent">{state.targetSpecies}</span>
        </h2>
        <p className="text-text-muted text-sm">
          {state.bundesland === "Thueringen" ? "Thüringen" : state.bundesland}{" "}
          &middot; {seasonLabel[state.season] ?? state.season} &middot;{" "}
          {state.waterTempC}°C &middot; {state.windKmh} km/h Wind
        </p>
      </div>

      {recommendations.length === 0 ? (
        <div className="card text-center py-12">
          <p className="text-text-muted">
            Keine Empfehlungen gefunden. Versuche andere Bedingungen.
          </p>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-3 gap-5">
          {recommendations.map((rec, i) => (
            <SpotCard
              key={rec.spot.id}
              rank={i + 1}
              spot={rec.spot}
              score={rec.score}
              reason={rec.reason}
              bestWindow={rec.bestWindow}
              breakdown={rec.breakdown}
            />
          ))}
        </div>
      )}

      <div className="text-center mt-8">
        <button onClick={onReset} className="btn-secondary">
          Neuen Versuch starten
        </button>
      </div>
    </div>
  );
}
