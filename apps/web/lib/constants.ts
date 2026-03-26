/** Fish species grouped by category. */
export const FISH_GROUPS = {
  Raubfische: ["Zander", "Hecht", "Barsch", "Wels", "Rapfen"],
  Friedfische: ["Karpfen", "Schleie", "Barbe", "Döbel"],
  Salmoniden: ["Forelle"],
  Sonstige: ["Aal"],
  "Köderfische": ["Köderfisch", "Rotauge", "Rotfeder", "Ukelei", "Gründling", "Güster"],
} as const;

/** All fish species available for recommendation (flat list). */
export const FISH_SPECIES = Object.values(FISH_GROUPS).flat();

export const BUNDESLAENDER = [
  "Sachsen-Anhalt",
  "Thueringen",
  "Sachsen",
] as const;

export const SEASONS = [
  { value: "Fruehling", label: "Frühling" },
  { value: "Sommer", label: "Sommer" },
  { value: "Herbst", label: "Herbst" },
  { value: "Winter", label: "Winter" },
] as const;

/** Auto-detect current season based on month. */
export function getCurrentSeason(): string {
  const month = new Date().getMonth(); // 0-11
  if (month >= 2 && month <= 4) return "Fruehling";
  if (month >= 5 && month <= 7) return "Sommer";
  if (month >= 8 && month <= 10) return "Herbst";
  return "Winter";
}
