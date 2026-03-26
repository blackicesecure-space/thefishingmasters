from __future__ import annotations

import math

SEASON_BONUS = {"Fruehling": 6.0, "Sommer": 4.0, "Herbst": 8.0, "Winter": -5.0}


def compute_bite_probability(
    *,
    water_temp_c: float,
    wind_kmh: float,
    pressure_hpa: float,
    moon_phase: float,
    season: str,
) -> float:
    """
    Compute baseline bite probability (5-95%).

    Args:
        water_temp_c: Water temperature in Celsius (0-35)
        wind_kmh: Wind speed in km/h (0-120)
        pressure_hpa: Barometric pressure in hPa (850-1100)
        moon_phase: Moon phase percentage (0=New, 50=Full, 100=New)
        season: One of Fruehling, Sommer, Herbst, Winter
    """
    temp_bonus = max(0.0, 18 - abs(water_temp_c - 14)) * 1.8
    wind_penalty = max(0.0, wind_kmh - 18) * 1.0
    pressure_bonus = max(0.0, 20 - abs(pressure_hpa - 1015)) * 0.7

    # Lunar bonus: best fishing at new moon (0/100) and full moon (50)
    # Uses cosine to create peaks at both new and full moon,
    # consistent with species_rules.py
    lunar_effect = (math.cos(moon_phase * 2 * math.pi / 100) + 1) / 2  # 0-1
    lunar_bonus = (lunar_effect - 0.3) * 15  # -4.5 to +10.5

    season_bonus = SEASON_BONUS.get(season, 0.0)

    score = 40 + temp_bonus + pressure_bonus + lunar_bonus + season_bonus - wind_penalty
    return max(5.0, min(95.0, round(score, 2)))
