"""
Species-specific fishing rules and recommendations.

Defines optimal conditions, best lures, tactics, and timing
for common freshwater fish species in Central Germany.
"""

from __future__ import annotations

import math
from dataclasses import dataclass


@dataclass
class SpeciesProfile:
    """Optimal fishing conditions for a specific species."""
    name: str
    name_de: str
    optimal_temp_min: float      # °C
    optimal_temp_max: float      # °C
    max_wind_kmh: float          # Above this, fishing is poor
    best_seasons: list[str]      # Fruehling, Sommer, Herbst, Winter
    best_times: list[str]        # Morgen, Mittag, Abend, Nacht, Daemmerung
    preferred_water: list[str]   # See, Fluss, Talsperre, Teich, Kanal
    preferred_depth_m: tuple[float, float]  # (min, max)
    lures: list[str]             # Recommended lures/baits
    tactics: list[str]           # Fishing techniques
    moon_sensitivity: float      # 0-1: how much moon phase affects this species


# Central German freshwater species database
SPECIES_DB: dict[str, SpeciesProfile] = {
    "Zander": SpeciesProfile(
        name="Zander", name_de="Zander",
        optimal_temp_min=10, optimal_temp_max=20,
        max_wind_kmh=25,
        best_seasons=["Herbst", "Fruehling"],
        best_times=["Daemmerung", "Nacht", "Morgen"],
        preferred_water=["See", "Talsperre", "Fluss", "Kanal"],
        preferred_depth_m=(3, 15),
        lures=["Gummifisch 10-15cm", "Wobbler (Suspender)", "Köderfisch am System"],
        tactics=["Faulenzen", "Jiggen am Grund", "Vertikalangeln"],
        moon_sensitivity=0.7,
    ),
    "Hecht": SpeciesProfile(
        name="Hecht", name_de="Hecht",
        optimal_temp_min=8, optimal_temp_max=18,
        max_wind_kmh=30,
        best_seasons=["Herbst", "Fruehling"],
        best_times=["Morgen", "Abend", "Mittag"],
        preferred_water=["See", "Fluss", "Teich", "Talsperre"],
        preferred_depth_m=(1, 8),
        lures=["Gummifisch 15-25cm", "Jerkbait", "Spinner 4-5", "Köderfisch"],
        tactics=["Spinnfischen", "Deadbait am Grund", "Schleppangeln"],
        moon_sensitivity=0.5,
    ),
    "Barsch": SpeciesProfile(
        name="Barsch", name_de="Barsch",
        optimal_temp_min=10, optimal_temp_max=22,
        max_wind_kmh=30,
        best_seasons=["Sommer", "Herbst"],
        best_times=["Morgen", "Abend"],
        preferred_water=["See", "Fluss", "Talsperre", "Kanal"],
        preferred_depth_m=(1, 10),
        lures=["Drop-Shot Wurm", "Gummifisch 5-8cm", "Spinner 1-3", "Crankbait"],
        tactics=["Drop-Shot", "Carolina-Rig", "Vertikalangeln", "Ultra-Light Spinnfischen"],
        moon_sensitivity=0.4,
    ),
    "Karpfen": SpeciesProfile(
        name="Karpfen", name_de="Karpfen",
        optimal_temp_min=15, optimal_temp_max=25,
        max_wind_kmh=20,
        best_seasons=["Sommer", "Fruehling", "Herbst"],
        best_times=["Morgen", "Nacht", "Abend"],
        preferred_water=["See", "Teich", "Fluss"],
        preferred_depth_m=(1, 6),
        lures=["Boilie 15-20mm", "Mais", "Tigernuss", "Pop-Up Boilie"],
        tactics=["Grundangeln mit Haar-Rig", "Method Feeder", "Oberflächenangeln"],
        moon_sensitivity=0.6,
    ),
    "Aal": SpeciesProfile(
        name="Aal", name_de="Aal",
        optimal_temp_min=12, optimal_temp_max=22,
        max_wind_kmh=20,
        best_seasons=["Sommer", "Fruehling"],
        best_times=["Nacht", "Daemmerung"],
        preferred_water=["Fluss", "See", "Kanal", "Teich"],
        preferred_depth_m=(1, 8),
        lures=["Tauwurm", "Köderfisch (klein)", "Wurmbündel"],
        tactics=["Grundangeln", "Legangeln", "Posenangeln nachts"],
        moon_sensitivity=0.8,
    ),
    "Forelle": SpeciesProfile(
        name="Forelle", name_de="Forelle",
        optimal_temp_min=6, optimal_temp_max=16,
        max_wind_kmh=20,
        best_seasons=["Fruehling", "Herbst"],
        best_times=["Morgen", "Abend"],
        preferred_water=["Fluss", "Talsperre"],
        preferred_depth_m=(0.5, 5),
        lures=["Spinner 1-2", "Wobbler 3-5cm", "Kunstfliege", "Bienenmade"],
        tactics=["Spinnfischen", "Fliegenfischen", "Sbirolinofischen"],
        moon_sensitivity=0.3,
    ),
    "Wels": SpeciesProfile(
        name="Wels", name_de="Wels",
        optimal_temp_min=15, optimal_temp_max=28,
        max_wind_kmh=25,
        best_seasons=["Sommer"],
        best_times=["Nacht", "Daemmerung"],
        preferred_water=["Fluss", "See", "Talsperre"],
        preferred_depth_m=(2, 20),
        lures=["Köderfisch gross", "Tauwurmbündel", "Pellet am Unterwasserpose"],
        tactics=["Grundangeln", "Klopfen/Wallerangeln", "Bojenmontage"],
        moon_sensitivity=0.7,
    ),
    "Schleie": SpeciesProfile(
        name="Schleie", name_de="Schleie",
        optimal_temp_min=14, optimal_temp_max=24,
        max_wind_kmh=15,
        best_seasons=["Sommer", "Fruehling"],
        best_times=["Morgen", "Abend"],
        preferred_water=["Teich", "See"],
        preferred_depth_m=(0.5, 4),
        lures=["Made", "Mais", "Wurm", "Mini-Boilie"],
        tactics=["Posenangeln", "Grundangeln leicht", "Method Feeder"],
        moon_sensitivity=0.4,
    ),
    "Barbe": SpeciesProfile(
        name="Barbe", name_de="Barbe",
        optimal_temp_min=12, optimal_temp_max=22,
        max_wind_kmh=30,
        best_seasons=["Sommer", "Fruehling"],
        best_times=["Morgen", "Abend", "Mittag"],
        preferred_water=["Fluss"],
        preferred_depth_m=(1, 5),
        lures=["Käse-Würfel", "Frühstücksfleisch", "Made", "Wurm"],
        tactics=["Grundangeln mit Futterkorb", "Feederangeln", "Posenangeln"],
        moon_sensitivity=0.3,
    ),
    "Rapfen": SpeciesProfile(
        name="Rapfen", name_de="Rapfen",
        optimal_temp_min=14, optimal_temp_max=24,
        max_wind_kmh=25,
        best_seasons=["Sommer", "Herbst"],
        best_times=["Morgen", "Abend"],
        preferred_water=["Fluss"],
        preferred_depth_m=(0.5, 3),
        lures=["Blinker silber", "Wobbler (Topwater)", "Spinner 3-4"],
        tactics=["Spinnfischen Oberfläche", "Speed-Spinning", "Twitchen"],
        moon_sensitivity=0.3,
    ),
    "Döbel": SpeciesProfile(
        name="Döbel", name_de="Döbel",
        optimal_temp_min=8, optimal_temp_max=22,
        max_wind_kmh=25,
        best_seasons=["Sommer", "Herbst", "Fruehling"],
        best_times=["Morgen", "Abend"],
        preferred_water=["Fluss"],
        preferred_depth_m=(0.5, 3),
        lures=["Brot", "Kirsche", "Spinner klein", "Kunstfliege"],
        tactics=["Oberflächenangeln", "Spinnfischen", "Posenangeln"],
        moon_sensitivity=0.2,
    ),
    # ===================== KÖDERFISCHE =====================
    "Köderfisch": SpeciesProfile(
        name="Köderfisch", name_de="Köderfisch (Sammelbegriff)",
        optimal_temp_min=8, optimal_temp_max=22,
        max_wind_kmh=25,
        best_seasons=["Fruehling", "Sommer", "Herbst"],
        best_times=["Morgen", "Mittag", "Abend"],
        preferred_water=["Fluss", "See", "Kanal", "Teich", "Bach"],
        preferred_depth_m=(0.3, 4),
        lures=["Made", "Wurm (klein)", "Brot", "Mais", "Teig", "Caster"],
        tactics=["Stippen", "Posenangeln flach", "Senke/Köderfischreuse", "Feederangeln leicht"],
        moon_sensitivity=0.15,
    ),
    "Rotauge": SpeciesProfile(
        name="Rotauge", name_de="Rotauge (Plötze)",
        optimal_temp_min=8, optimal_temp_max=22,
        max_wind_kmh=25,
        best_seasons=["Fruehling", "Sommer", "Herbst"],
        best_times=["Morgen", "Abend", "Mittag"],
        preferred_water=["See", "Fluss", "Kanal", "Teich"],
        preferred_depth_m=(0.5, 5),
        lures=["Made", "Wurm (klein)", "Brot", "Mais", "Caster"],
        tactics=["Posenangeln", "Feederangeln", "Stippen"],
        moon_sensitivity=0.2,
    ),
    "Rotfeder": SpeciesProfile(
        name="Rotfeder", name_de="Rotfeder",
        optimal_temp_min=12, optimal_temp_max=24,
        max_wind_kmh=20,
        best_seasons=["Sommer", "Fruehling"],
        best_times=["Morgen", "Abend"],
        preferred_water=["See", "Teich", "Kanal"],
        preferred_depth_m=(0.3, 3),
        lures=["Brot", "Made", "Teig", "kleine Fliege"],
        tactics=["Oberflächenangeln", "Posenangeln flach", "Stippen"],
        moon_sensitivity=0.15,
    ),
    "Ukelei": SpeciesProfile(
        name="Ukelei", name_de="Ukelei (Laube)",
        optimal_temp_min=10, optimal_temp_max=25,
        max_wind_kmh=25,
        best_seasons=["Sommer", "Fruehling", "Herbst"],
        best_times=["Morgen", "Mittag", "Abend"],
        preferred_water=["Fluss", "See", "Kanal"],
        preferred_depth_m=(0, 2),
        lures=["Made (einzeln)", "Brotflocke", "Mini-Teig"],
        tactics=["Stippen Oberfläche", "Posenangeln flach", "Match-Rute"],
        moon_sensitivity=0.1,
    ),
    "Gründling": SpeciesProfile(
        name="Gründling", name_de="Gründling",
        optimal_temp_min=8, optimal_temp_max=20,
        max_wind_kmh=30,
        best_seasons=["Sommer", "Fruehling", "Herbst"],
        best_times=["Morgen", "Mittag", "Abend"],
        preferred_water=["Fluss", "Bach"],
        preferred_depth_m=(0.3, 2),
        lures=["Wurm (klein)", "Made", "Mistwurm"],
        tactics=["Posenangeln Grund", "Leichte Grundmontage", "Stippen"],
        moon_sensitivity=0.1,
    ),
    "Güster": SpeciesProfile(
        name="Güster", name_de="Güster (Blicke)",
        optimal_temp_min=10, optimal_temp_max=22,
        max_wind_kmh=25,
        best_seasons=["Sommer", "Fruehling", "Herbst"],
        best_times=["Morgen", "Abend"],
        preferred_water=["See", "Fluss", "Kanal"],
        preferred_depth_m=(1, 6),
        lures=["Made", "Wurm", "Mais", "Caster"],
        tactics=["Feederangeln", "Posenangeln", "Grundangeln leicht"],
        moon_sensitivity=0.15,
    ),
}

# Aliases (common misspellings / alternate names)
_ALIASES: dict[str, str] = {
    "Doebel": "Döbel",
    "Aesche": "Forelle",  # Similar conditions
    "Saibling": "Forelle",
    "Maraene": "Forelle",
    "Karausche": "Schleie",
    "Seeforelle": "Forelle",
    "Koederfisch": "Köderfisch",
    "Plötze": "Rotauge",
    "Plotze": "Rotauge",
    "Laube": "Ukelei",
    "Gruendling": "Gründling",
    "Guester": "Güster",
    "Blicke": "Güster",
}


def get_species_profile(species: str) -> SpeciesProfile | None:
    """Get the profile for a species (case-insensitive, with aliases)."""
    # Direct match
    if species in SPECIES_DB:
        return SPECIES_DB[species]
    # Case-insensitive match against DB keys
    species_lower = species.lower()
    for key, profile in SPECIES_DB.items():
        if key.lower() == species_lower:
            return profile
    # Case-insensitive alias lookup
    for alias_key, alias_target in _ALIASES.items():
        if alias_key.lower() == species_lower:
            return SPECIES_DB.get(alias_target)
    return None


def compute_species_score(
    species: str,
    water_temp_c: float,
    wind_kmh: float,
    season: str,
    moon_phase_pct: float,
) -> tuple[float, list[str]]:
    """
    Compute a species-specific bite adjustment factor.

    Returns:
        (factor, reasons) where factor is 0.3 to 1.5
        and reasons explain the adjustment.
    """
    profile = get_species_profile(species)
    if not profile:
        return 1.0, [f"Keine spezifischen Daten fuer {species}"]

    factor = 1.0
    reasons: list[str] = []

    # Temperature match
    if profile.optimal_temp_min <= water_temp_c <= profile.optimal_temp_max:
        # Within optimal range
        mid = (profile.optimal_temp_min + profile.optimal_temp_max) / 2
        closeness = 1 - abs(water_temp_c - mid) / (profile.optimal_temp_max - profile.optimal_temp_min)
        temp_bonus = 0.1 + closeness * 0.2  # +10% to +30%
        factor += temp_bonus
        reasons.append(
            f"Wassertemperatur {water_temp_c}°C ist optimal fuer {species} "
            f"({profile.optimal_temp_min}-{profile.optimal_temp_max}°C)"
        )
    elif water_temp_c < profile.optimal_temp_min:
        diff = profile.optimal_temp_min - water_temp_c
        penalty = min(0.4, diff * 0.05)
        factor -= penalty
        reasons.append(
            f"Wassertemperatur {water_temp_c}°C ist {diff:.0f}°C unter dem Optimum fuer {species}"
        )
    else:
        diff = water_temp_c - profile.optimal_temp_max
        penalty = min(0.4, diff * 0.05)
        factor -= penalty
        reasons.append(
            f"Wassertemperatur {water_temp_c}°C ist {diff:.0f}°C ueber dem Optimum fuer {species}"
        )

    # Wind
    if wind_kmh > profile.max_wind_kmh:
        penalty = min(0.3, (wind_kmh - profile.max_wind_kmh) * 0.015)
        factor -= penalty
        reasons.append(f"Wind {wind_kmh} km/h ist zu stark fuer {species} (max {profile.max_wind_kmh})")

    # Season match
    if season in profile.best_seasons:
        factor += 0.15
        reasons.append(f"{season} ist eine gute Saison fuer {species}")
    else:
        factor -= 0.1
        reasons.append(f"{season} ist keine optimale Saison fuer {species}")

    # Moon sensitivity
    # Best around new (0/100) and full (50) moon
    moon_effect = (math.cos(moon_phase_pct * 2 * math.pi / 100) + 1) / 2  # 0-1
    moon_bonus = (moon_effect - 0.5) * profile.moon_sensitivity * 0.2
    factor += moon_bonus
    if moon_bonus > 0.05:
        reasons.append("Guenstige Mondphase fuer diese Art")
    elif moon_bonus < -0.05:
        reasons.append("Ungünstige Mondphase fuer diese Art")

    # Clamp
    factor = max(0.3, min(1.5, round(factor, 2)))
    return factor, reasons


def get_lure_recommendation(species: str, season: str) -> dict[str, list[str]]:
    """
    Get lure and tactic recommendations for a species.

    Returns dict with 'lures' and 'tactics' lists.
    """
    profile = get_species_profile(species)
    if not profile:
        return {"lures": ["Universalkoeder"], "tactics": ["Grundangeln"]}

    return {
        "lures": profile.lures[:3],  # Top 3 for brevity
        "tactics": profile.tactics[:2],  # Top 2
    }


