"use client";

import { useState } from "react";
import { useQuery, useMutation } from "@apollo/client";
import { SPOTS_QUERY, SUBMIT_FEEDBACK } from "@/lib/graphql/queries";
import { FISH_SPECIES } from "@/lib/constants";
import { shortBundesland } from "@/lib/format";
import Link from "next/link";

export default function FeedbackPage() {
  const [spotId, setSpotId] = useState("");
  const [success, setSuccess] = useState<boolean | null>(null);
  const [note, setNote] = useState("");
  const [targetSpecies, setTargetSpecies] = useState("");
  const [crowdLevel, setCrowdLevel] = useState<number | null>(null);
  const [submitted, setSubmitted] = useState(false);

  const { data: spotsData, loading: spotsLoading } = useQuery(SPOTS_QUERY);

  const [submitFeedback, { loading: submitting, error }] = useMutation(
    SUBMIT_FEEDBACK,
    {
      onCompleted: () => setSubmitted(true),
    }
  );

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (!spotId || success === null) return;

    submitFeedback({
      variables: {
        input: {
          spotId,
          success,
          note: note || null,
          targetSpecies: targetSpecies || null,
          crowdLevel: crowdLevel,
        },
      },
    });
  }

  function handleReset() {
    setSpotId("");
    setSuccess(null);
    setNote("");
    setTargetSpecies("");
    setCrowdLevel(null);
    setSubmitted(false);
  }

  if (submitted) {
    return (
      <div className="card max-w-lg mx-auto text-center py-12">
        <div className="text-4xl mb-4">
          {success ? "🎣" : "🤷"}
        </div>
        <h2 className="text-xl font-bold mb-2">
          {success ? "Petri Heil!" : "Danke für dein Feedback!"}
        </h2>
        <p className="text-text-muted mb-6">
          Dein Feedback hilft uns, die Empfehlungen zu verbessern.
        </p>
        <div className="flex gap-3 justify-center">
          <button onClick={handleReset} className="btn-secondary">
            Weiteres Feedback
          </button>
          <Link href="/flow" className="btn-primary">
            Neue Empfehlung
          </Link>
        </div>
      </div>
    );
  }

  return (
    <form onSubmit={handleSubmit} className="card max-w-lg mx-auto">
      <h2 className="text-xl font-bold mb-2">Feedback geben</h2>
      <p className="text-text-muted text-sm mb-6">
        Wie war dein Angeltag? Dein Feedback verbessert unsere Empfehlungen.
      </p>

      {error && (
        <div className="bg-error/10 border border-error/30 text-error rounded-input p-3 mb-4 text-sm">
          Fehler: {error.message}
        </div>
      )}

      <div className="space-y-5">
        {/* Spot Selection */}
        <div>
          <label className="block text-sm text-text-muted mb-1.5">
            Gewässer
          </label>
          <select
            className="select-field"
            value={spotId}
            onChange={(e) => setSpotId(e.target.value)}
            required
          >
            <option value="">Spot wählen...</option>
            {spotsLoading && <option disabled>Lade Spots...</option>}
            {spotsData?.spots?.map(
              (spot: { id: string; name: string; bundesland: string }) => (
                <option key={spot.id} value={spot.id}>
                  {spot.name} ({shortBundesland(spot.bundesland)})
                </option>
              )
            )}
          </select>
        </div>

        {/* Target Species */}
        <div>
          <label className="block text-sm text-text-muted mb-1.5">
            Zielfisch (optional)
          </label>
          <select
            className="select-field"
            value={targetSpecies}
            onChange={(e) => setTargetSpecies(e.target.value)}
          >
            <option value="">Keine Angabe</option>
            {FISH_SPECIES.map((f) => (
              <option key={f} value={f}>{f}</option>
            ))}
          </select>
        </div>

        {/* Success Toggle */}
        <div>
          <label className="block text-sm text-text-muted mb-2">
            Ergebnis
          </label>
          <div className="flex gap-3">
            <button
              type="button"
              onClick={() => setSuccess(true)}
              className={`flex-1 py-3 rounded-input text-center font-medium transition-colors ${
                success === true
                  ? "bg-success/20 border-2 border-success text-success"
                  : "bg-bg border border-border text-text-muted hover:border-success/50"
              }`}
            >
              Gefangen!
            </button>
            <button
              type="button"
              onClick={() => setSuccess(false)}
              className={`flex-1 py-3 rounded-input text-center font-medium transition-colors ${
                success === false
                  ? "bg-error/20 border-2 border-error text-error"
                  : "bg-bg border border-border text-text-muted hover:border-error/50"
              }`}
            >
              Schneider
            </button>
          </div>
        </div>

        {/* Crowd Level */}
        <div>
          <label className="block text-sm text-text-muted mb-2">
            Andrang am Wasser (optional)
          </label>
          <div className="flex gap-2">
            {[0, 1, 2, 3, 4, 5].map((n) => (
              <button
                key={n}
                type="button"
                onClick={() => setCrowdLevel(n)}
                className={`w-10 h-10 rounded-full text-sm font-medium transition-colors ${
                  crowdLevel === n
                    ? "bg-warning/20 border-2 border-warning text-warning"
                    : "bg-bg border border-border text-text-muted hover:border-warning/50"
                }`}
              >
                {n}
              </button>
            ))}
          </div>
          <div className="flex justify-between text-xs text-text-muted mt-1">
            <span>Leer</span>
            <span>Überfüllt</span>
          </div>
        </div>

        {/* Note */}
        <div>
          <label className="block text-sm text-text-muted mb-1.5">
            Kommentar (optional)
          </label>
          <textarea
            className="input-field resize-none"
            rows={3}
            maxLength={500}
            placeholder="z.B. Köder, Uhrzeit, besondere Bedingungen..."
            value={note}
            onChange={(e) => setNote(e.target.value)}
          />
          <div className="text-right text-xs text-text-muted mt-1">
            {note.length}/500
          </div>
        </div>
      </div>

      <button
        type="submit"
        className="btn-primary w-full mt-8"
        disabled={!spotId || success === null || submitting}
      >
        {submitting ? "Sende..." : "Feedback absenden"}
      </button>
    </form>
  );
}
