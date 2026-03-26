"""
OpenWeather API client with in-memory caching.

Provides current weather and forecast data for fishing spot locations.
Requires OPENWEATHER_API_KEY environment variable.
"""

from __future__ import annotations

import json
import os
import time
import urllib.request
from dataclasses import dataclass, asdict

# Cache: key = "lat,lon" (rounded to 2 decimals), value = (timestamp, data)
_cache: dict[str, tuple[float, dict]] = {}
CACHE_TTL_S = 900  # 15 minutes


@dataclass
class WeatherData:
    temp_celsius: float
    wind_speed_kmh: float
    wind_direction: int       # degrees 0-360
    pressure_hpa: float
    cloud_cover: int          # percent 0-100
    humidity: int             # percent 0-100
    precipitation_mm: float
    description: str
    icon: str

    def to_dict(self) -> dict:
        return asdict(self)


# Default fallback for when API is unavailable
_FALLBACK = WeatherData(
    temp_celsius=15.0,
    wind_speed_kmh=10.0,
    wind_direction=180,
    pressure_hpa=1013.0,
    cloud_cover=50,
    humidity=60,
    precipitation_mm=0.0,
    description="Keine Wetterdaten verfuegbar (Fallback)",
    icon="03d",
)


def _cache_key(lat: float, lon: float) -> str:
    return f"{lat:.2f},{lon:.2f}"


def _get_cached(lat: float, lon: float) -> WeatherData | None:
    key = _cache_key(lat, lon)
    if key in _cache:
        ts, data = _cache[key]
        if time.time() - ts < CACHE_TTL_S:
            return WeatherData(**data)
    return None


def _set_cache(lat: float, lon: float, data: WeatherData) -> None:
    key = _cache_key(lat, lon)
    _cache[key] = (time.time(), data.to_dict())


def get_api_key() -> str | None:
    return os.environ.get("OPENWEATHER_API_KEY")


def fetch_current_weather(lat: float, lon: float) -> WeatherData:
    """
    Fetch current weather for a location.

    Uses OpenWeather Current Weather API.
    Falls back to default values if API key is missing or request fails.
    """
    # Check cache first
    cached = _get_cached(lat, lon)
    if cached:
        return cached

    api_key = get_api_key()
    if not api_key:
        return _FALLBACK

    url = (
        f"https://api.openweathermap.org/data/2.5/weather"
        f"?lat={lat}&lon={lon}&appid={api_key}&units=metric&lang=de"
    )

    try:
        req = urllib.request.Request(url, headers={"User-Agent": "TheFishingMasters/0.1"})
        with urllib.request.urlopen(req, timeout=8) as resp:
            raw = json.loads(resp.read().decode("utf-8"))
    except Exception:
        return _FALLBACK

    wind_data = raw.get("wind", {})
    weather_main = raw.get("main", {})
    weather_desc = raw.get("weather", [{}])[0]
    rain = raw.get("rain", {})
    snow = raw.get("snow", {})

    # Wind speed from m/s to km/h
    wind_ms = wind_data.get("speed", 0)
    wind_kmh = round(wind_ms * 3.6, 1)

    precipitation = rain.get("1h", 0) + snow.get("1h", 0)

    data = WeatherData(
        temp_celsius=round(weather_main.get("temp", 15.0), 1),
        wind_speed_kmh=wind_kmh,
        wind_direction=int(wind_data.get("deg", 0)),
        pressure_hpa=float(weather_main.get("pressure", 1013)),
        cloud_cover=int(raw.get("clouds", {}).get("all", 50)),
        humidity=int(weather_main.get("humidity", 60)),
        precipitation_mm=round(precipitation, 2),
        description=weather_desc.get("description", ""),
        icon=weather_desc.get("icon", "03d"),
    )

    _set_cache(lat, lon, data)
    return data


def fetch_forecast(lat: float, lon: float, hours_ahead: int = 24) -> list[WeatherData]:
    """
    Fetch weather forecast (3-hour intervals) for a location.

    Returns forecast entries up to `hours_ahead` hours into the future.
    """
    api_key = get_api_key()
    if not api_key:
        return [_FALLBACK]

    url = (
        f"https://api.openweathermap.org/data/2.5/forecast"
        f"?lat={lat}&lon={lon}&appid={api_key}&units=metric&lang=de"
    )

    try:
        req = urllib.request.Request(url, headers={"User-Agent": "TheFishingMasters/0.1"})
        with urllib.request.urlopen(req, timeout=8) as resp:
            raw = json.loads(resp.read().decode("utf-8"))
    except Exception:
        return [_FALLBACK]

    entries = raw.get("list", [])
    max_entries = hours_ahead // 3  # 3-hour intervals

    result = []
    for entry in entries[:max_entries]:
        wind_data = entry.get("wind", {})
        weather_main = entry.get("main", {})
        weather_desc = entry.get("weather", [{}])[0]
        rain = entry.get("rain", {})
        snow = entry.get("snow", {})

        wind_ms = wind_data.get("speed", 0)
        precipitation = rain.get("3h", 0) + snow.get("3h", 0)

        result.append(WeatherData(
            temp_celsius=round(weather_main.get("temp", 15.0), 1),
            wind_speed_kmh=round(wind_ms * 3.6, 1),
            wind_direction=int(wind_data.get("deg", 0)),
            pressure_hpa=float(weather_main.get("pressure", 1013)),
            cloud_cover=int(entry.get("clouds", {}).get("all", 50)),
            humidity=int(weather_main.get("humidity", 60)),
            precipitation_mm=round(precipitation, 2),
            description=weather_desc.get("description", ""),
            icon=weather_desc.get("icon", "03d"),
        ))

    return result if result else [_FALLBACK]


def clear_cache() -> None:
    """Clear the weather cache (for testing)."""
    _cache.clear()
