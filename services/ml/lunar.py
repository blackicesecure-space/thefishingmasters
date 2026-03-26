"""
Lunar phase and solunar period calculator.

Pure math implementation – no external API or library required.
Based on the John Alden Knight solunar theory and astronomical algorithms
by Jean Meeus.
"""

from __future__ import annotations

import math
from dataclasses import dataclass, asdict
from datetime import datetime, date, timedelta, timezone


@dataclass
class LunarData:
    """Lunar and solunar data for a specific date and location."""
    date: str                      # ISO date
    moon_phase_pct: float          # 0=New, 50=Full, 100=New again
    moon_phase_name: str           # Neumond, Zunehmend, Vollmond, Abnehmend
    moon_illumination: float       # 0-100%
    solunar_major_1: str           # HH:MM-HH:MM (2h window)
    solunar_major_2: str           # HH:MM-HH:MM
    solunar_minor_1: str           # HH:MM-HH:MM (1h window)
    solunar_minor_2: str           # HH:MM-HH:MM
    solunar_rating: int            # 1-5 (5 = best fishing day)

    def to_dict(self) -> dict:
        return asdict(self)


def _julian_day(dt: datetime) -> float:
    """Convert datetime to Julian Day Number."""
    y = dt.year
    m = dt.month
    d = dt.day + dt.hour / 24.0 + dt.minute / 1440.0

    if m <= 2:
        y -= 1
        m += 12

    A = int(y / 100)
    B = 2 - A + int(A / 4)

    return int(365.25 * (y + 4716)) + int(30.6001 * (m + 1)) + d + B - 1524.5


def _moon_phase_angle(dt: datetime) -> float:
    """
    Calculate the moon's phase angle (0-360 degrees).
    0/360 = New Moon, 180 = Full Moon.

    Uses the synodic month approach: fraction of the current lunar cycle
    mapped to 0-360 degrees. More reliable than simplified elongation.
    """
    # Known new moon reference: January 6, 2000 at 18:14 UTC
    KNOWN_NEW_MOON_JD = 2451550.26
    SYNODIC_MONTH = 29.53059  # days

    jd = _julian_day(dt)
    days_since = jd - KNOWN_NEW_MOON_JD
    # Phase within current cycle (0.0 = new, 0.5 = full, 1.0 = new again)
    cycle_fraction = (days_since % SYNODIC_MONTH) / SYNODIC_MONTH
    phase_deg = cycle_fraction * 360.0

    return phase_deg


def compute_moon_phase(dt: datetime) -> tuple[float, str, float]:
    """
    Compute moon phase percentage, name, and illumination.

    Returns:
        (phase_pct, phase_name, illumination_pct)
        phase_pct: 0 = New Moon, 50 = Full Moon, 100 = back to New
    """
    angle = _moon_phase_angle(dt)
    phase_pct = (angle / 360.0) * 100.0

    # Illumination: 0% at New, 100% at Full
    illumination = (1 - math.cos(math.radians(angle))) / 2 * 100

    # Phase name
    if phase_pct < 6.25 or phase_pct >= 93.75:
        name = "Neumond"
    elif phase_pct < 25:
        name = "Zunehmende Sichel"
    elif phase_pct < 31.25:
        name = "Erstes Viertel"
    elif phase_pct < 43.75:
        name = "Zunehmender Mond"
    elif phase_pct < 56.25:
        name = "Vollmond"
    elif phase_pct < 68.75:
        name = "Abnehmender Mond"
    elif phase_pct < 75:
        name = "Letztes Viertel"
    else:
        name = "Abnehmende Sichel"

    return round(phase_pct, 1), name, round(illumination, 1)


def _moon_transit_hour(dt: datetime, lon: float) -> float:
    """
    Estimate the moon's transit (meridian crossing) hour for a location.

    Simplified: uses the moon's daily retardation (~50 min/day)
    and longitude offset.
    """
    jd = _julian_day(dt)
    # Days since a known new moon (Jan 6, 2000 18:14 UTC)
    days_since_ref = jd - 2451550.26
    # Moon's daily retardation in hours
    retardation = (days_since_ref % 29.53059) * (24.0 * 50.47 / (29.53059 * 60))
    # Longitude correction (15 degrees = 1 hour)
    lon_correction = lon / 15.0
    transit = (12.0 + retardation + lon_correction) % 24
    return transit


def compute_solunar_periods(
    target_date: date, lat: float, lon: float
) -> tuple[list[tuple[str, str]], list[tuple[str, str]], int]:
    """
    Calculate solunar major and minor periods.

    Major periods (~2h): Moon transit (overhead) and moon underfoot (opposite).
    Minor periods (~1h): Moonrise and moonset.

    Returns:
        (major_periods, minor_periods, rating)
        Each period is (start_time, end_time) as "HH:MM"
    """
    dt = datetime(target_date.year, target_date.month, target_date.day,
                  12, 0, tzinfo=timezone.utc)

    transit_hour = _moon_transit_hour(dt, lon)

    # Major period 1: Moon transit (overhead) ± 1 hour
    major_1_start = (transit_hour - 1) % 24
    major_1_end = (transit_hour + 1) % 24

    # Major period 2: Moon underfoot (opposite side) ± 1 hour
    underfoot = (transit_hour + 12) % 24
    major_2_start = (underfoot - 1) % 24
    major_2_end = (underfoot + 1) % 24

    # Minor periods: approximately 6.2h before/after transit
    minor_offset = 6.2
    minor_1_center = (transit_hour - minor_offset) % 24
    minor_1_start = (minor_1_center - 0.5) % 24
    minor_1_end = (minor_1_center + 0.5) % 24

    minor_2_center = (transit_hour + minor_offset) % 24
    minor_2_start = (minor_2_center - 0.5) % 24
    minor_2_end = (minor_2_center + 0.5) % 24

    def fmt(h: float) -> str:
        hours = int(h) % 24
        minutes = int((h % 1) * 60)
        return f"{hours:02d}:{minutes:02d}"

    majors = [
        (fmt(major_1_start), fmt(major_1_end)),
        (fmt(major_2_start), fmt(major_2_end)),
    ]
    minors = [
        (fmt(minor_1_start), fmt(minor_1_end)),
        (fmt(minor_2_start), fmt(minor_2_end)),
    ]

    # Solunar rating (1-5) based on moon phase
    phase_pct, _, illumination = compute_moon_phase(dt)
    # Best fishing around new and full moon
    if phase_pct < 10 or (45 < phase_pct < 55) or phase_pct > 90:
        rating = 5
    elif phase_pct < 20 or (35 < phase_pct < 65) or phase_pct > 80:
        rating = 4
    elif phase_pct < 30 or phase_pct > 70:
        rating = 3
    else:
        rating = 2

    return majors, minors, rating


def get_lunar_data(target_date: date, lat: float = 51.3, lon: float = 12.0) -> LunarData:
    """
    Get complete lunar + solunar data for a date and location.

    Defaults to Leipzig coordinates (central to our target region).
    """
    dt = datetime(target_date.year, target_date.month, target_date.day,
                  12, 0, tzinfo=timezone.utc)

    phase_pct, phase_name, illumination = compute_moon_phase(dt)
    majors, minors, rating = compute_solunar_periods(target_date, lat, lon)

    return LunarData(
        date=target_date.isoformat(),
        moon_phase_pct=phase_pct,
        moon_phase_name=phase_name,
        moon_illumination=illumination,
        solunar_major_1=f"{majors[0][0]}-{majors[0][1]}",
        solunar_major_2=f"{majors[1][0]}-{majors[1][1]}",
        solunar_minor_1=f"{minors[0][0]}-{minors[0][1]}",
        solunar_minor_2=f"{minors[1][0]}-{minors[1][1]}",
        solunar_rating=rating,
    )
