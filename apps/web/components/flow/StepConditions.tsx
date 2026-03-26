"use client";

import { useState, useEffect } from "react";
import { useLazyQuery } from "@apollo/client";
import { SEASONS, getCurrentSeason } from "@/lib/constants";
import { WEATHER_QUERY, LUNAR_QUERY } from "@/lib/graphql/queries";
import { displayBundesland, weatherEmoji, moonEmoji } from "@/lib/format";
import type { FlowState } from "@/app/flow/page";

/** Central coordinates per Bundesland for weather lookups. */
const BUNDESLAND_COORDS: Record<string, { lat: number; lon: number }> = {
  "Sachsen-Anhalt": { lat: 51.95, lon: 11.69 },
  Thueringen: { lat: 50.98, lon: 11.03 },
  Sachsen: { lat: 51.05, lon: 13.74 },
};

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
  const [moonPhase, setMoonPhase] = useState(initial.moonPhase);
  const [autoLoaded, setAutoLoaded] = useState(false);

  // Weather & lunar auto-fetch
  const [fetchWeather, { data: weatherData }] = useLazyQuery(WEATHER_QUERY);
  const [fetchLunar, { data: lunarData }] = useLazyQuery(LUNAR_QUERY);

  useEffect(() => {
    const coords = BUNDESLAND_COORDS[initial.bundesland] ?? { lat: 51.3, lon: 12.0 };
    fetchWeather({ variables: { lat: coords.lat, lon: coords.lon } });
    fetchLunar({ variables: { lat: coords.lat, lon: coords.lon } });
  }, [initial.bundesland, fetchWeather, fetchLunar]);

  // Auto-populate when data arrives
  useEffect(() => {
    if (weatherData?.weather && !autoLoaded) {
      const w = weatherData.weather;
      setWaterTemp(Math.round(w.tempCelsius));
      setWind(Math.round(w.windSpeedKmh));
      setPressure(Math.round(w.pressureHpa));
      setAutoLoaded(true);
    }
  }, [weatherData, autoLoaded]);

  useEffect(() => {
    if (lunarData?.lunar) {
      setMoonPhase(Math.round(lunarData.lunar.moonPhasePct));
    }
  }, [lunarData]);

  function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    onNext({
      waterTempC: waterTemp,
      windKmh: wind,
      season,
      pressureHpa: pressure,
      moonPhase,
    });
  }

  const weather = weatherData?.weather;
  const lunar = lunarData?.lunar;

  return (
    <form onSubmit={handleSubmit} className="card max-w-lg mx-auto">
      <h2 className="text-xl font-bold mb-2">Schritt 2: Aktuelle Bedingungen</h2>
      <p className="text-text-muted text-sm mb-4">
        Ziel: <span className="text-accent">{initial.targetSpecies}</span> in{" "}
        <span className="text-accent">{displayBundesland(initial.bundesland)}</span>
      </p>

      {/* Auto-loaded context cards */}
      {(weather || lunar) && (
        <div className="grid grid-cols-2 gap-3 mb-6">
          {weather && (
            <div className="bg-bg rounded-card p-3 border border-border">
              <div className="text-xs text-text-muted mb-1">Aktuelles Wetter</div>
              <div className="text-lg font-bold">
                {weatherEmoji(weather.icon)} {weather.tempCelsius.toFixed(1)}°C
              </div>
              <div className="text-xs text-text-muted">
                {weather.windSpeedKmh.toFixed(0)} km/h Wind &middot; {weather.pressureHpa.toFixed(0)} hPa
              </div>
              <div className="text-xs text-text-muted mt-0.5">{weather.description}</div>
            </div>
          )}
          {lunar && (
            <div className="bg-bg rounded-card p-3 border border-border">
              <div className="text-xs text-text-muted mb-1">Mondphase</div>
              <div className="text-lg font-bold">
                {moonEmoji(lunar.moonPhasePct)} {lunar.moonPhaseName}
              </div>
              <div className="text-xs text-text-muted">
                {lunar.moonIllumination.toFixed(0)}% Beleuchtung
              </div>
              <div className="text-xs text-text-muted mt-0.5">
                Solunar: {lunar.solunarMajor1}
              </div>
            </div>
          )}
        </div>
      )}

      {autoLoaded && (
        <div className="bg-accent/10 border border-accent/20 rounded-input p-2 mb-4 text-xs text-accent text-center">
          Werte automatisch aus aktuellen Wetterdaten geladen. Du kannst sie anpassen.
        </div>
      )}

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
