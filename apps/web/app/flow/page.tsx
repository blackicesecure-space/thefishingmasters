"use client";

import { useState } from "react";
import { useLazyQuery } from "@apollo/client";
import { RECOMMENDATIONS_QUERY } from "@/lib/graphql/queries";
import { getCurrentSeason } from "@/lib/constants";
import StepFish from "@/components/flow/StepFish";
import StepConditions from "@/components/flow/StepConditions";
import StepResults from "@/components/flow/StepResults";

export interface FlowState {
  // Step 1
  targetSpecies: string;
  bundesland: string;
  // Step 2
  waterTempC: number;
  windKmh: number;
  season: string;
  pressureHpa: number;
  moonPhase: number;
}

const initialState: FlowState = {
  targetSpecies: "",
  bundesland: "",
  waterTempC: 14,
  windKmh: 10,
  season: getCurrentSeason(),
  pressureHpa: 1013,
  moonPhase: 50,
};

export default function FlowPage() {
  const [step, setStep] = useState(1);
  const [state, setState] = useState<FlowState>(initialState);
  const [error, setError] = useState("");

  const [fetchRecommendations, { data, loading }] = useLazyQuery(
    RECOMMENDATIONS_QUERY,
    {
      onCompleted: () => setStep(3),
      onError: (err) => setError(err.message),
    }
  );

  function handleStep1(species: string, bundesland: string) {
    setState((s) => ({ ...s, targetSpecies: species, bundesland }));
    setStep(2);
    setError("");
  }

  function handleStep2(conditions: Partial<FlowState>) {
    const next = { ...state, ...conditions };
    setState(next);
    setError("");

    fetchRecommendations({
      variables: {
        input: {
          targetSpecies: next.targetSpecies,
          waterTempC: next.waterTempC,
          windKmh: next.windKmh,
          pressureHpa: next.pressureHpa,
          moonPhase: next.moonPhase,
          season: next.season,
        },
      },
    });
  }

  function handleReset() {
    setState(initialState);
    setStep(1);
    setError("");
  }

  return (
    <div>
      {/* Progress Bar */}
      <div className="flex items-center gap-2 mb-8">
        {[1, 2, 3].map((n) => (
          <div key={n} className="flex items-center gap-2 flex-1">
            <div
              className={`w-8 h-8 rounded-full flex items-center justify-center text-sm font-bold transition-colors ${
                step >= n
                  ? "bg-accent text-bg"
                  : "bg-bg-card border border-border text-text-muted"
              }`}
            >
              {n}
            </div>
            <span
              className={`text-sm hidden sm:inline ${
                step >= n ? "text-text" : "text-text-muted"
              }`}
            >
              {n === 1 ? "Zielfisch" : n === 2 ? "Bedingungen" : "Ergebnisse"}
            </span>
            {n < 3 && (
              <div
                className={`flex-1 h-px ${
                  step > n ? "bg-accent" : "bg-border"
                }`}
              />
            )}
          </div>
        ))}
      </div>

      {/* Error */}
      {error && (
        <div className="bg-error/10 border border-error/30 text-error rounded-card p-4 mb-6">
          {error}
        </div>
      )}

      {/* Steps */}
      {step === 1 && <StepFish onNext={handleStep1} initial={state} />}

      {step === 2 && (
        <StepConditions
          onNext={handleStep2}
          onBack={() => setStep(1)}
          initial={state}
          loading={loading}
        />
      )}

      {step === 3 && data?.recommendations && (
        <StepResults
          recommendations={data.recommendations}
          state={state}
          onReset={handleReset}
        />
      )}
    </div>
  );
}
