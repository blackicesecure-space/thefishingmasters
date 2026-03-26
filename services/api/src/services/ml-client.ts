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
}

const ML_API_BASE = process.env.ML_API_BASE_URL ?? 'http://127.0.0.1:8001';
const ML_TIMEOUT_MS = 5000;

/**
 * Call the ML service /predict endpoint.
 * Includes timeout and retry logic (1 retry on failure).
 */
export async function predictBiteProbability(
  req: MLPredictionRequest
): Promise<MLPredictionResponse> {
  const url = `${ML_API_BASE}/predict`;

  for (let attempt = 0; attempt < 2; attempt++) {
    try {
      const controller = new AbortController();
      const timer = setTimeout(() => controller.abort(), ML_TIMEOUT_MS);

      const response = await fetch(url, {
        method: 'POST',
        headers: { 'content-type': 'application/json' },
        body: JSON.stringify(req),
        signal: controller.signal,
      });
      clearTimeout(timer);

      if (!response.ok) {
        throw new Error(`ML API returned ${response.status}: ${await response.text()}`);
      }

      return (await response.json()) as MLPredictionResponse;
    } catch (err) {
      if (attempt === 1) throw err;
      // Wait 500ms before retry
      await new Promise((r) => setTimeout(r, 500));
    }
  }

  // Unreachable, but TypeScript needs it
  throw new Error('ML prediction failed after retries');
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
