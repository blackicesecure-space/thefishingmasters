"use client";

import { useState } from "react";
import { FISH_SPECIES, BUNDESLAENDER } from "@/lib/constants";
import type { FlowState } from "@/app/flow/page";

interface Props {
  onNext: (species: string, bundesland: string) => void;
  initial: FlowState;
}

export default function StepFish({ onNext, initial }: Props) {
  const [species, setSpecies] = useState(initial.targetSpecies);
  const [bundesland, setBundesland] = useState(initial.bundesland);

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (species && bundesland) {
      onNext(species, bundesland);
    }
  }

  return (
    <form onSubmit={handleSubmit} className="card max-w-lg mx-auto">
      <h2 className="text-xl font-bold mb-6">Schritt 1: Was willst du fangen?</h2>

      <div className="space-y-5">
        <div>
          <label className="block text-sm text-text-muted mb-1.5">Zielfisch</label>
          <select
            className="select-field"
            value={species}
            onChange={(e) => setSpecies(e.target.value)}
            required
          >
            <option value="">Fischart wählen...</option>
            <optgroup label="Raubfische">
              {FISH_SPECIES.filter((_, i) => i < 5).map((f) => (
                <option key={f} value={f}>{f}</option>
              ))}
            </optgroup>
            <optgroup label="Friedfische">
              {FISH_SPECIES.filter((_, i) => i >= 5 && i < 9).map((f) => (
                <option key={f} value={f}>{f}</option>
              ))}
            </optgroup>
            <optgroup label="Salmoniden">
              <option value="Forelle">Forelle</option>
            </optgroup>
            <optgroup label="Sonstige">
              <option value="Aal">Aal</option>
            </optgroup>
            <optgroup label="Köderfische">
              {FISH_SPECIES.filter((_, i) => i >= 11).map((f) => (
                <option key={f} value={f}>{f}</option>
              ))}
            </optgroup>
          </select>
        </div>

        <div>
          <label className="block text-sm text-text-muted mb-1.5">Region</label>
          <select
            className="select-field"
            value={bundesland}
            onChange={(e) => setBundesland(e.target.value)}
            required
          >
            <option value="">Bundesland wählen...</option>
            {BUNDESLAENDER.map((b) => (
              <option key={b} value={b}>
                {b === "Thueringen" ? "Thüringen" : b}
              </option>
            ))}
          </select>
        </div>
      </div>

      <button
        type="submit"
        className="btn-primary w-full mt-8"
        disabled={!species || !bundesland}
      >
        Weiter
      </button>
    </form>
  );
}
