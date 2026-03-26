from __future__ import annotations

from datetime import date, datetime
from typing import Literal

from fastapi import FastAPI, Query
from pydantic import BaseModel, Field

try:
    from .scoring import compute_bite_probability
    from .weather_client import fetch_current_weather, WeatherData
    from .lunar import get_lunar_data, LunarData
    from .species_rules import (
        compute_species_score,
        get_lure_recommendation,
        get_species_profile,
    )
except ImportError:
    from scoring import compute_bite_probability
    from weather_client import fetch_current_weather, WeatherData
    from lunar import get_lunar_data, LunarData
    from species_rules import (
        compute_species_score,
        get_lure_recommendation,
        get_species_profile,
    )

Season = Literal["Fruehling", "Sommer", "Herbst", "Winter"]


# ---- Request/Response Models ----

class PredictionRequest(BaseModel):
    target_species: str = Field(min_length=2, max_length=40)
    water_temp_c: float = Field(ge=0, le=35)
    wind_kmh: float = Field(ge=0, le=120)
    pressure_hpa: float = Field(ge=850, le=1100)
    moon_phase: float = Field(ge=0, le=100)
    season: Season


class PredictionResponse(BaseModel):
    bite_probability: float
    confidence: float
    model_version: str


class WeatherResponse(BaseModel):
    temp_celsius: float
    wind_speed_kmh: float
    wind_direction: int
    pressure_hpa: float
    cloud_cover: int
    humidity: int
    precipitation_mm: float
    description: str
    icon: str


class LunarResponse(BaseModel):
    date: str
    moon_phase_pct: float
    moon_phase_name: str
    moon_illumination: float
    solunar_major_1: str
    solunar_major_2: str
    solunar_minor_1: str
    solunar_minor_2: str
    solunar_rating: int


class RecommendRequest(BaseModel):
    target_species: str = Field(min_length=2, max_length=40)
    lat: float = Field(ge=46, le=56)
    lon: float = Field(ge=5, le=16)
    season: Season


class RecommendResponse(BaseModel):
    bite_probability: float
    species_factor: float
    adjusted_probability: float
    confidence: float
    model_version: str
    weather: WeatherResponse
    lunar: LunarResponse
    species_reasons: list[str]
    lure_recommendation: dict[str, list[str]]
    best_times: list[str]


# ---- App ----

app = FastAPI(title="The Fishing Masters ML API", version="0.2.0")


@app.get("/health")
def health() -> dict[str, str]:
    """Liveness endpoint for monitoring."""
    return {"status": "ok", "version": "0.2.0"}


@app.post("/predict", response_model=PredictionResponse)
def predict(payload: PredictionRequest) -> PredictionResponse:
    """Return baseline bite probability prediction (original endpoint)."""
    bite_probability = compute_bite_probability(
        water_temp_c=payload.water_temp_c,
        wind_kmh=payload.wind_kmh,
        pressure_hpa=payload.pressure_hpa,
        moon_phase=payload.moon_phase,
        season=payload.season,
    )
    confidence = 0.62 if bite_probability < 60 else 0.71
    return PredictionResponse(
        bite_probability=bite_probability,
        confidence=confidence,
        model_version="baseline-heuristic-v1",
    )


@app.get("/weather", response_model=WeatherResponse)
def weather(
    lat: float = Query(ge=46, le=56),
    lon: float = Query(ge=5, le=16),
) -> WeatherResponse:
    """Fetch current weather for a location (cached 15min)."""
    data = fetch_current_weather(lat, lon)
    return WeatherResponse(
        temp_celsius=data.temp_celsius,
        wind_speed_kmh=data.wind_speed_kmh,
        wind_direction=data.wind_direction,
        pressure_hpa=data.pressure_hpa,
        cloud_cover=data.cloud_cover,
        humidity=data.humidity,
        precipitation_mm=data.precipitation_mm,
        description=data.description,
        icon=data.icon,
    )


@app.get("/lunar", response_model=LunarResponse)
def lunar(
    target_date: str = Query(default="", description="ISO date YYYY-MM-DD, defaults to today"),
    lat: float = Query(default=51.3, ge=46, le=56),
    lon: float = Query(default=12.0, ge=5, le=16),
) -> LunarResponse:
    """Get lunar phase and solunar periods for a date/location."""
    if target_date:
        try:
            d = date.fromisoformat(target_date)
        except ValueError:
            from fastapi import HTTPException
            raise HTTPException(status_code=422, detail=f"Ungültiges Datum: '{target_date}'. Format: YYYY-MM-DD")
    else:
        d = date.today()

    data = get_lunar_data(d, lat, lon)
    return LunarResponse(**data.to_dict())


@app.post("/recommend", response_model=RecommendResponse)
def recommend(payload: RecommendRequest) -> RecommendResponse:
    """
    Combined endpoint: Weather + Lunar + Species + Scoring.

    This is the primary endpoint for the recommendation engine.
    Fetches real-time weather, computes lunar data, applies
    species-specific adjustments, and returns a complete recommendation.
    """
    today = date.today()

    # 1. Weather (real-time or fallback)
    weather_data = fetch_current_weather(payload.lat, payload.lon)

    # 2. Lunar data
    lunar_data = get_lunar_data(today, payload.lat, payload.lon)

    # 3. Base bite probability
    base_probability = compute_bite_probability(
        water_temp_c=weather_data.temp_celsius,
        wind_kmh=weather_data.wind_speed_kmh,
        pressure_hpa=weather_data.pressure_hpa,
        moon_phase=lunar_data.moon_phase_pct,
        season=payload.season,
    )

    # 4. Species-specific adjustment
    species_factor, species_reasons = compute_species_score(
        species=payload.target_species,
        water_temp_c=weather_data.temp_celsius,
        wind_kmh=weather_data.wind_speed_kmh,
        season=payload.season,
        moon_phase_pct=lunar_data.moon_phase_pct,
    )

    adjusted = max(5.0, min(95.0, round(base_probability * species_factor, 2)))

    # 5. Lure recommendation
    lure_rec = get_lure_recommendation(payload.target_species, payload.season)

    # 6. Best fishing times
    profile = get_species_profile(payload.target_species)
    best_times = profile.best_times[:3] if profile else ["Morgen", "Abend"]

    # Confidence based on data quality
    has_real_weather = weather_data.description != "Keine Wetterdaten verfuegbar (Fallback)"
    confidence = 0.75 if has_real_weather else 0.55

    return RecommendResponse(
        bite_probability=base_probability,
        species_factor=species_factor,
        adjusted_probability=adjusted,
        confidence=confidence,
        model_version="baseline-heuristic-v2-species",
        weather=WeatherResponse(
            temp_celsius=weather_data.temp_celsius,
            wind_speed_kmh=weather_data.wind_speed_kmh,
            wind_direction=weather_data.wind_direction,
            pressure_hpa=weather_data.pressure_hpa,
            cloud_cover=weather_data.cloud_cover,
            humidity=weather_data.humidity,
            precipitation_mm=weather_data.precipitation_mm,
            description=weather_data.description,
            icon=weather_data.icon,
        ),
        lunar=LunarResponse(**lunar_data.to_dict()),
        species_reasons=species_reasons,
        lure_recommendation=lure_rec,
        best_times=best_times,
    )
