/**
 * HTTP client for the Python ML prediction service.
 */

export interface MLPredictionRequest {
  target_species: string;
  water_temp_c: number;
  wind_kmh: number;
  pressure_hpa: number;
  moon_phase: number;
  season: string;
}

export interface MLPredictionResponse {
  bite_probability: number;
  confidence: number;
  model_version: string;
  species_preferences: MLSpeciesPreferences | null;
}

export interface MLWeatherResponse {
  temp_celsius: number;
  wind_speed_kmh: number;
  wind_direction: number;
  pressure_hpa: number;
  cloud_cover: number;
  humidity: number;
  precipitation_mm: number;
  description: string;
  icon: string;
}

export interface MLLunarResponse {
  date: string;
  moon_phase_pct: number;
  moon_phase_name: string;
  moon_illumination: number;
  solunar_major_1: string;
  solunar_major_2: string;
  solunar_minor_1: string;
  solunar_minor_2: string;
  solunar_rating: number;
}

export interface MLSpeciesPreferences {
  preferred_water: string[];
  preferred_depth_min: number;
  preferred_depth_max: number;
  preferred_structures: Record<string, number>;
}

export interface MLRecommendResponse {
  bite_probability: number;
  species_factor: number;
  adjusted_probability: number;
  confidence: number;
  model_version: string;
  weather: MLWeatherResponse;
  lunar: MLLunarResponse;
  species_reasons: string[];
  lure_recommendation: { lures: string[]; tactics: string[] };
  best_times: string[];
  species_preferences: MLSpeciesPreferences | null;
}

const ML_API_BASE = process.env.ML_API_BASE_URL ?? 'http://127.0.0.1:8001';
const ML_TIMEOUT_MS = 5000;

async function mlFetch<T>(url: string, options?: RequestInit): Promise<T> {
  for (let attempt = 0; attempt < 2; attempt++) {
    try {
      const controller = new AbortController();
      const timer = setTimeout(() => controller.abort(), ML_TIMEOUT_MS);

      const response = await fetch(url, {
        ...options,
        signal: controller.signal,
      });
      clearTimeout(timer);

      if (!response.ok) {
        throw new Error(`ML API returned ${response.status}: ${await response.text()}`);
      }

      return (await response.json()) as T;
    } catch (err) {
      if (attempt === 1) throw err;
      await new Promise((r) => setTimeout(r, 500));
    }
  }
  throw new Error('ML request failed after retries');
}

/**
 * Call the ML service /predict endpoint.
 */
export async function predictBiteProbability(
  req: MLPredictionRequest
): Promise<MLPredictionResponse> {
  return mlFetch<MLPredictionResponse>(`${ML_API_BASE}/predict`, {
    method: 'POST',
    headers: { 'content-type': 'application/json' },
    body: JSON.stringify(req),
  });
}

/**
 * Fetch current weather from ML service.
 */
export async function fetchWeather(lat: number, lon: number): Promise<MLWeatherResponse> {
  return mlFetch<MLWeatherResponse>(
    `${ML_API_BASE}/weather?lat=${lat}&lon=${lon}`
  );
}

/**
 * Fetch lunar data from ML service.
 */
export async function fetchLunar(
  targetDate?: string,
  lat = 51.3,
  lon = 12.0,
): Promise<MLLunarResponse> {
  const params = new URLSearchParams();
  if (targetDate) params.set('target_date', targetDate);
  params.set('lat', String(lat));
  params.set('lon', String(lon));
  return mlFetch<MLLunarResponse>(`${ML_API_BASE}/lunar?${params}`);
}

/**
 * Get combined recommendation from ML (weather + lunar + species + scoring).
 */
export async function fetchRecommend(
  targetSpecies: string,
  lat: number,
  lon: number,
  season: string,
): Promise<MLRecommendResponse> {
  return mlFetch<MLRecommendResponse>(`${ML_API_BASE}/recommend`, {
    method: 'POST',
    headers: { 'content-type': 'application/json' },
    body: JSON.stringify({
      target_species: targetSpecies,
      lat,
      lon,
      season,
    }),
  });
}

/**
 * Check ML service health.
 */
export async function checkMLHealth(): Promise<boolean> {
  try {
    const controller = new AbortController();
    const timer = setTimeout(() => controller.abort(), 3000);
    const res = await fetch(`${ML_API_BASE}/health`, { signal: controller.signal });
    clearTimeout(timer);
    return res.ok;
  } catch {
    return false;
  }
}
