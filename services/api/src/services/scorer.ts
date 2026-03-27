/**
 * Multi-factor scoring engine.
 *
 * Composite score (0-100):
 *   35% bite probability (ML)
 *   30% spot quality (habitat fit: species, water type, depth, structures)
 *   12% convenience (parking, accessibility)
 *   13% crowd factor
 *   10% personalization (placeholder)
 */

import type { SpotRow } from '../db/supabase.js';

export interface SpeciesPreferences {
  preferred_water: string[];
  preferred_depth_min: number;
  preferred_depth_max: number;
  preferred_structures: Record<string, number>;
}

export interface ScoreBreakdown {
  bite: number;       // 0-35
  quality: number;    // 0-30
  convenience: number; // 0-12
  crowd: number;      // 0-13
  personal: number;   // 0-10
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
  speciesPreferences?: SpeciesPreferences | null;
}

/**
 * Calculate the composite score for a single spot.
 */
export function scoreSpot(input: ScoringInput): ScoreBreakdown {
  const { spot, biteProbability, targetSpecies, season, speciesPreferences } = input;
  const reasons: string[] = [];

  // 1. Bite probability (35% weight, ML score 0-100 → 0-35)
  const bite = (biteProbability / 100) * 35;
  if (biteProbability >= 70) {
    reasons.push(`Hohe Beisswahrscheinlichkeit (${biteProbability.toFixed(0)}%)`);
  } else if (biteProbability < 30) {
    reasons.push(`Niedrige Beisswahrscheinlichkeit (${biteProbability.toFixed(0)}%)`);
  }

  // 2. Spot quality (30% weight) — habitat fit
  let quality = 2; // reduced base

  // 2a. Species presence (+8)
  const speciesPresent = spot.fischarten.includes(targetSpecies);
  if (speciesPresent) {
    quality += 8;
    reasons.push(`${targetSpecies} ist im Gewaesser vorhanden`);
  } else {
    reasons.push(`${targetSpecies} nicht als Bestand gemeldet`);
  }

  if (speciesPreferences) {
    // 2b. Water type match (+6)
    if (speciesPreferences.preferred_water.includes(spot.gewaesser_typ)) {
      quality += 6;
      reasons.push(`Gewaessertyp ${spot.gewaesser_typ} passt zu ${targetSpecies}`);
    } else {
      reasons.push(
        `${targetSpecies} bevorzugt ${speciesPreferences.preferred_water.join('/')}, nicht ${spot.gewaesser_typ}`
      );
    }

    // 2c. Depth range match (0-5)
    if (spot.max_tiefe_m != null) {
      const depthMin = speciesPreferences.preferred_depth_min;
      const depthMax = speciesPreferences.preferred_depth_max;
      const depth = spot.max_tiefe_m;

      if (depth >= depthMin && depth <= depthMax) {
        quality += 5;
        reasons.push(
          `Tiefe ${depth}m liegt im optimalen Bereich fuer ${targetSpecies} (${depthMin}-${depthMax}m)`
        );
      } else {
        // Partial credit within 50% margin outside range
        const range = depthMax - depthMin;
        const margin = Math.max(range * 0.5, 2);
        let distOutside: number;
        if (depth < depthMin) {
          distOutside = depthMin - depth;
        } else {
          distOutside = depth - depthMax;
        }
        if (distOutside <= margin) {
          const partial = Math.round((1 - distOutside / margin) * 4) + 1;
          quality += Math.min(4, partial);
        }
      }
    } else {
      quality += 2; // neutral when no depth data
    }

    // 2d. Structure relevance (0-6)
    const spotStructures = spot.strukturen ?? [];
    const prefStructures = speciesPreferences.preferred_structures;
    if (spotStructures.length > 0 && Object.keys(prefStructures).length > 0) {
      let totalWeight = 0;
      let matchCount = 0;
      for (const s of spotStructures) {
        if (s in prefStructures) {
          totalWeight += prefStructures[s];
          matchCount++;
        }
      }
      if (matchCount > 0) {
        const avgWeight = totalWeight / matchCount;
        const structScore = Math.min(6, Math.round(avgWeight * 6 * 10) / 10);
        quality += structScore;
        // Collect top matching structure names for reason
        const matched = spotStructures.filter((s) => s in prefStructures);
        if (matched.length > 0) {
          reasons.push(`Gute Strukturen fuer ${targetSpecies}: ${matched.slice(0, 3).join(', ')}`);
        }
      }
    } else {
      quality += 2; // neutral when no structure data
    }
  } else {
    // Fallback when no species preferences available (ML service down)
    if (spot.flaeche_ha && spot.flaeche_ha > 100) quality += 3;
    if (spot.max_tiefe_m && spot.max_tiefe_m > 10) quality += 2;
    quality += 2; // neutral structure + water type
  }

  // Bonus for spot size regardless of species prefs
  if (spot.flaeche_ha && spot.flaeche_ha > 100) quality += 3;
  quality = Math.min(30, quality);

  // 3. Convenience (12% weight)
  let convenience = 3;
  if (spot.parkplatz) {
    convenience += 4;
    reasons.push('Parkplatz vorhanden');
  }
  if (spot.angelkarte_preis_tag !== null && spot.angelkarte_preis_tag <= 10) {
    convenience += 3;
  }
  if (spot.beschreibung) convenience += 2;
  convenience = Math.min(12, convenience);

  // 4. Crowd factor (13% weight) – lower crowd = higher score
  const crowdScore = Math.max(0, 13 - spot.avg_crowd_level * 2.6);
  if (spot.avg_crowd_level <= 1) {
    reasons.push('Wenig Andrang erwartet');
  } else if (spot.avg_crowd_level >= 4) {
    reasons.push('Hoeher Andrang moeglich');
  }

  // 5. Personalization placeholder (10% weight)
  const personal = 5; // neutral midpoint

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
  topN = 3,
  speciesPreferences?: SpeciesPreferences | null,
): ScoredSpot[] {
  const scored = spots.map((spot) => {
    const breakdown = scoreSpot({ spot, biteProbability, targetSpecies, season, speciesPreferences });
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
