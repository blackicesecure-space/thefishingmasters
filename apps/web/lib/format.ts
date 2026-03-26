/** Display-friendly Bundesland names (ASCII → German). */
const BUNDESLAND_DISPLAY: Record<string, string> = {
  "Thueringen": "Thüringen",
  "Sachsen-Anhalt": "Sachsen-Anhalt",
  Sachsen: "Sachsen",
};

/** Short abbreviations for Bundesländer. */
const BUNDESLAND_SHORT: Record<string, string> = {
  "Sachsen-Anhalt": "ST",
  "Thueringen": "TH",
  Sachsen: "SN",
};

/** Convert internal Bundesland key to display name. */
export function displayBundesland(value: string): string {
  return BUNDESLAND_DISPLAY[value] ?? value;
}

/** Convert Bundesland to short abbreviation. */
export function shortBundesland(value: string): string {
  return BUNDESLAND_SHORT[value] ?? value;
}

/** Map OpenWeather icon code to an emoji. */
export function weatherEmoji(icon: string): string {
  if (icon.startsWith("01")) return "☀️";
  if (icon.startsWith("02")) return "⛅";
  if (icon.startsWith("03") || icon.startsWith("04")) return "☁️";
  if (icon.startsWith("09") || icon.startsWith("10")) return "🌧️";
  if (icon.startsWith("11")) return "⛈️";
  if (icon.startsWith("13")) return "🌨️";
  if (icon.startsWith("50")) return "🌫️";
  return "🌤️";
}

/** Solunar rating to descriptive text. */
export function solunarLabel(rating: number): string {
  if (rating >= 4) return "Ausgezeichnet";
  if (rating >= 3) return "Gut";
  if (rating >= 2) return "Mäßig";
  return "Schwach";
}

/** Moon phase name to emoji. */
export function moonEmoji(phasePct: number): string {
  if (phasePct < 6.25) return "🌑";
  if (phasePct < 18.75) return "🌒";
  if (phasePct < 31.25) return "🌓";
  if (phasePct < 43.75) return "🌔";
  if (phasePct < 56.25) return "🌕";
  if (phasePct < 68.75) return "🌖";
  if (phasePct < 81.25) return "🌗";
  if (phasePct < 93.75) return "🌘";
  return "🌑";
}
