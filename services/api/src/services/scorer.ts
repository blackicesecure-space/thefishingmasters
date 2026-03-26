/**
 * Multi-factor scoring engine.
 *
 * Composite score (0-100):
 *   40% bite probability (ML)
 *   25% spot quality (base rating + species match)
 *   15% convenience (parking, accessibility)
 *   15% crowd factor
 *    5% personalization (placeholder)
 */

import type { SpotRow } from '../db/supabase.js';

export interface ScoreBreakdown {
  bite: number;       // 0-40
  quality: number;    // 0-25
  convenience: number; // 0-15
  crowd: number;      // 0-15
  personal: number;   // 0-5
  total: number;      // 0-100
  reasons: string[];
}

export interface ScoredSpot {
  spot: SpotRow;
  score: number;
  breakdown: ScoreBreakdown;
  reason: string;
  bestWindow: string;
}

interface ScoringInput {
  spot: SpotRow;
  biteProbability: number; // 0-100 from ML
  targetSpecies: string;
  season: string;
}

/**
 * Calculate the composite score for a single spot.
 */
export function scoreSpot(input: ScoringInput): ScoreBreakdown {
  const { spot, biteProbability, targetSpecies, season } = input;
  const reasons: string[] = [];

  // 1. Bite probability (40% weight, ML score 0-100 → 0-40)
  const bite = (biteProbability / 100) * 40;
  if (biteProbability >= 70) {
    reasons.push(`Hohe Beisswahrscheinlichkeit (${biteProbability.toFixed(0)}%)`);
  } else if (biteProbability < 30) {
    reasons.push(`Niedrige Beisswahrscheinlichkeit (${biteProbability.toFixed(0)}%)`);
  }

  // 2. Spot quality (25% weight)
  let quality = 10; // base score
  const speciesPresent = spot.fischarten.includes(targetSpecies);
  if (speciesPresent) {
    quality += 10;
    reasons.push(`${targetSpecies} ist im Gewaesser vorhanden`);
  } else {
    reasons.push(`${targetSpecies} nicht als Bestand gemeldet`);
  }
  // Bonus for spot size/depth
  if (spot.flaeche_ha && spot.flaeche_ha > 100) quality += 3;
  if (spot.max_tiefe_m && spot.max_tiefe_m > 10) quality += 2;
  quality = Math.min(25, quality);

  // 3. Convenience (15% weight)
  let convenience = 5;
  if (spot.parkplatz) {
    convenience += 5;
    reasons.push('Parkplatz vorhanden');
  }
  if (spot.angelkarte_preis_tag !== null && spot.angelkarte_preis_tag <= 10) {
    convenience += 3;
  }
  if (spot.beschreibung) convenience += 2; // better documented = easier to find
  convenience = Math.min(15, convenience);

  // 4. Crowd factor (15% weight) – lower crowd = higher score
  const crowdScore = Math.max(0, 15 - spot.avg_crowd_level * 3);
  if (spot.avg_crowd_level <= 1) {
    reasons.push('Wenig Andrang erwartet');
  } else if (spot.avg_crowd_level >= 4) {
    reasons.push('Hoeher Andrang moeglich');
  }

  // 5. Personalization placeholder (5% weight)
  const personal = 2.5; // neutral default

  const total = Math.round(bite + quality + convenience + crowdScore + personal);

  return {
    bite: Math.round(bite * 10) / 10,
    quality: Math.round(quality * 10) / 10,
    convenience: Math.round(convenience * 10) / 10,
    crowd: Math.round(crowdScore * 10) / 10,
    personal: Math.round(personal * 10) / 10,
    total: Math.min(100, Math.max(0, total)),
    reasons,
  };
}

/**
 * Determine best fishing window based on season.
 */
export function bestFishingWindow(season: string): string {
  switch (season) {
    case 'Fruehling':
      return '06:00–10:00 & 17:00–20:00';
    case 'Sommer':
      return '05:00–08:00 & 20:00–23:00';
    case 'Herbst':
      return '07:00–11:00 & 16:00–19:00';
    case 'Winter':
      return '10:00–15:00';
    default:
      return '06:00–10:00 & 17:00–20:00';
  }
}

/**
 * Score multiple spots and return top-N sorted by score.
 */
export function rankSpots(
  spots: SpotRow[],
  biteProbability: number,
  targetSpecies: string,
  season: string,
  topN = 3
): ScoredSpot[] {
  const scored = spots.map((spot) => {
    const breakdown = scoreSpot({ spot, biteProbability, targetSpecies, season });
    return {
      spot,
      score: breakdown.total,
      breakdown,
      reason: breakdown.reasons.join('. ') + '.',
      bestWindow: bestFishingWindow(season),
    };
  });

  scored.sort((a, b) => b.score - a.score);
  return scored.slice(0, topN);
}
