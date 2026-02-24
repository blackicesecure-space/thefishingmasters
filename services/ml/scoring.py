from __future__ import annotations

SEASON_BONUS = {"Fruehling": 6.0, "Sommer": 4.0, "Herbst": 8.0, "Winter": -5.0}


def compute_bite_probability(
    *,
    water_temp_c: float,
    wind_kmh: float,
    pressure_hpa: float,
    moon_phase: float,
    season: str,
) -> float:
    temp_bonus = max(0.0, 18 - abs(water_temp_c - 14)) * 1.8
    wind_penalty = max(0.0, wind_kmh - 18) * 1.0
    pressure_bonus = max(0.0, 20 - abs(pressure_hpa - 1015)) * 0.7
    lunar_bonus = (50 - abs(moon_phase - 55)) * 0.25
    season_bonus = SEASON_BONUS[season]

    score = 40 + temp_bonus + pressure_bonus + lunar_bonus + season_bonus - wind_penalty
    return max(5.0, min(95.0, round(score, 2)))
