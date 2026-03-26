"use client";

import { useState } from "react";
import { SEASONS, getCurrentSeason } from "@/lib/constants";
import type { FlowState } from "@/app/flow/page";

interface Props {
  onNext: (conditions: Partial<FlowState>) => void;
  onBack: () => void;
  initial: FlowState;
  loading: boolean;
}

export default function StepConditions({ onNext, onBack, initial, loading }: Props) {
  const [waterTemp, setWaterTemp] = useState(initial.waterTempC);
  const [wind, setWind] = useState(initial.windKmh);
  const [season, setSeason] = useState(initial.season || getCurrentSeason());
  const [pressure, setPressure] = useState(initial.pressureHpa);

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    onNext({
      waterTempC: waterTemp,
      windKmh: wind,
      season,
      pressureHpa: pressure,
      moonPhase: 50, // Auto-calculated by ML service in production
    });
  }

  return (
    <form onSubmit={handleSubmit} className="card max-w-lg mx-auto">
      <h2 className="text-xl font-bold mb-2">Schritt 2: Aktuelle Bedingungen</h2>
      <p className="text-text-muted text-sm mb-6">
        Ziel: <span className="text-accent">{initial.targetSpecies}</span> in{" "}
        <span className="text-accent">
          {initial.bundesland === "Thueringen" ? "Thüringen" : initial.bundesland}
        </span>
      </p>

      <div className="space-y-5">
        <div>
          <label className="block text-sm text-text-muted mb-1.5">
            Wassertemperatur: <span className="text-accent">{waterTemp}°C</span>
          </label>
          <input
            type="range"
            min={0}
            max={30}
            step={0.5}
            value={waterTemp}
            onChange={(e) => setWaterTemp(Number(e.target.value))}
            className="w-full accent-accent"
          />
          <div className="flex justify-between text-xs text-text-muted mt-1">
            <span>0°C</span>
            <span>15°C</span>
            <span>30°C</span>
          </div>
        </div>

        <div>
          <label className="block text-sm text-text-muted mb-1.5">
            Wind: <span className="text-accent">{wind} km/h</span>
          </label>
          <input
            type="range"
            min={0}
            max={60}
            step={1}
            value={wind}
            onChange={(e) => setWind(Number(e.target.value))}
            className="w-full accent-accent"
          />
          <div className="flex justify-between text-xs text-text-muted mt-1">
            <span>Windstill</span>
            <span>Mäßig</span>
            <span>Sturm</span>
          </div>
        </div>

        <div>
          <label className="block text-sm text-text-muted mb-1.5">
            Luftdruck: <span className="text-accent">{pressure} hPa</span>
          </label>
          <input
            type="range"
            min={970}
            max={1050}
            step={1}
            value={pressure}
            onChange={(e) => setPressure(Number(e.target.value))}
            className="w-full accent-accent"
          />
          <div className="flex justify-between text-xs text-text-muted mt-1">
            <span>Tief</span>
            <span>Normal</span>
            <span>Hoch</span>
          </div>
        </div>

        <div>
          <label className="block text-sm text-text-muted mb-1.5">Saison</label>
          <select
            className="select-field"
            value={season}
            onChange={(e) => setSeason(e.target.value)}
          >
            {SEASONS.map((s) => (
              <option key={s.value} value={s.value}>
                {s.label}
              </option>
            ))}
          </select>
        </div>
      </div>

      <div className="flex gap-3 mt-8">
        <button type="button" className="btn-secondary flex-1" onClick={onBack}>
          Zurück
        </button>
        <button type="submit" className="btn-primary flex-1" disabled={loading}>
          {loading ? "Berechne..." : "Empfehlung berechnen"}
        </button>
      </div>
    </form>
  );
}
