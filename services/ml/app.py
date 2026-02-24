from __future__ import annotations

from typing import Literal

from fastapi import FastAPI
from pydantic import BaseModel, Field

from scoring import compute_bite_probability

Season = Literal["Fruehling", "Sommer", "Herbst", "Winter"]


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


app = FastAPI(title="The Fishing Masters ML API", version="0.1.0")


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}


@app.post("/predict", response_model=PredictionResponse)
def predict(payload: PredictionRequest) -> PredictionResponse:
    # Lightweight MVP baseline heuristic (to be replaced by sklearn model).
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
