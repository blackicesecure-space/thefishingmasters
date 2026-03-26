"use client";

import Link from "next/link";
import ScoreBar from "./ScoreBar";

interface Spot {
  id: string;
  name: string;
  bundesland: string;
  gewaesserTyp: string;
  fishSpecies: string[];
  avgCrowdLevel: number;
}

interface Breakdown {
  bite: number;
  quality: number;
  convenience: number;
  crowd: number;
  personal: number;
  total: number;
  reasons: string[];
}

interface Lure {
  lures: string[];
  tactics: string[];
}

interface Props {
  rank: number;
  spot: Spot;
  score: number;
  reason: string;
  bestWindow: string;
  breakdown: Breakdown;
  lure: Lure;
}

export default function SpotCard({ rank, spot, score, reason, bestWindow, breakdown, lure }: Props) {
  const rankColors = ["text-accent", "text-warning", "text-text-muted"];
  const rankBorders = ["border-accent/40", "border-warning/40", "border-border"];

  return (
    <div className={`card border ${rankBorders[rank - 1] ?? "border-border"}`}>
      <div className="flex items-start justify-between mb-3">
        <div>
          <span className={`text-sm font-bold ${rankColors[rank - 1] ?? ""}`}>
            #{rank}
          </span>
          <h3 className="text-lg font-bold">{spot.name}</h3>
          <p className="text-text-muted text-sm">
            {spot.gewaesserTyp} &middot;{" "}
            {spot.bundesland === "Thueringen" ? "Thüringen" : spot.bundesland}
          </p>
        </div>
        <div className="text-right">
          <div className="text-2xl font-bold text-accent">{score}</div>
          <div className="text-xs text-text-muted">/ 100</div>
        </div>
      </div>

      {/* Score Breakdown Bars */}
      <div className="space-y-1.5 mb-4">
        <ScoreBar label="Beißchance" value={breakdown.bite} max={40} color="bg-accent" />
        <ScoreBar label="Qualität" value={breakdown.quality} max={25} color="bg-success" />
        <ScoreBar label="Convenience" value={breakdown.convenience} max={15} color="bg-warning" />
        <ScoreBar label="Crowd" value={breakdown.crowd} max={15} color="bg-accent-dim" />
        <ScoreBar label="Personal" value={breakdown.personal} max={5} color="bg-text-muted" />
      </div>

      {/* Reason */}
      <p className="text-sm text-text-muted mb-3">{reason}</p>

      {/* Best Window */}
      <div className="flex items-center gap-2 mb-3">
        <span className="badge">Beste Zeit: {bestWindow}</span>
      </div>

      {/* Lure Recommendation */}
      <div className="bg-bg rounded-input p-3 mb-3">
        <div className="text-xs text-text-muted mb-1.5 font-medium">Köderempfehlung</div>
        <div className="flex flex-wrap gap-1.5 mb-2">
          {lure.lures.map((l) => (
            <span key={l} className="text-xs bg-accent/10 text-accent px-2 py-0.5 rounded-full">
              {l}
            </span>
          ))}
        </div>
        <div className="text-xs text-text-muted">
          Taktik: {lure.tactics.join(", ")}
        </div>
      </div>

      {/* Fish Species Tags */}
      <div className="flex flex-wrap gap-1.5">
        {spot.fishSpecies.slice(0, 5).map((fish) => (
          <span key={fish} className="badge text-xs">
            {fish}
          </span>
        ))}
        {spot.fishSpecies.length > 5 && (
          <span className="badge text-xs badge-warning">
            +{spot.fishSpecies.length - 5}
          </span>
        )}
      </div>

      {/* Link to detail */}
      <Link
        href={`/spots/${spot.id}`}
        className="block mt-4 text-sm text-accent hover:underline"
      >
        Spot-Details anzeigen →
      </Link>
    </div>
  );
}
