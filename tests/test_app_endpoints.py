"""
Test the FastAPI app endpoints using TestClient (no network needed).
"""

import unittest

from fastapi.testclient import TestClient
from services.ml.app import app


class AppEndpointTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.client = TestClient(app)

    def test_health(self):
        r = self.client.get("/health")
        self.assertEqual(r.status_code, 200)
        data = r.json()
        self.assertEqual(data["status"], "ok")
        self.assertIn("version", data)

    def test_predict_valid(self):
        r = self.client.post("/predict", json={
            "target_species": "Zander",
            "water_temp_c": 14,
            "wind_kmh": 10,
            "pressure_hpa": 1013,
            "moon_phase": 50,
            "season": "Herbst",
        })
        self.assertEqual(r.status_code, 200)
        data = r.json()
        self.assertIn("bite_probability", data)
        self.assertGreaterEqual(data["bite_probability"], 5)
        self.assertLessEqual(data["bite_probability"], 95)
        self.assertIn("confidence", data)
        self.assertIn("model_version", data)

    def test_predict_invalid_season(self):
        r = self.client.post("/predict", json={
            "target_species": "Zander",
            "water_temp_c": 14,
            "wind_kmh": 10,
            "pressure_hpa": 1013,
            "moon_phase": 50,
            "season": "Banane",
        })
        self.assertEqual(r.status_code, 422)

    def test_predict_temp_out_of_range(self):
        r = self.client.post("/predict", json={
            "target_species": "Hecht",
            "water_temp_c": 50,
            "wind_kmh": 10,
            "pressure_hpa": 1013,
            "moon_phase": 50,
            "season": "Sommer",
        })
        self.assertEqual(r.status_code, 422)

    def test_lunar_default_date(self):
        r = self.client.get("/lunar")
        self.assertEqual(r.status_code, 200)
        data = r.json()
        self.assertIn("moon_phase_pct", data)
        self.assertIn("moon_phase_name", data)
        self.assertIn("solunar_rating", data)
        self.assertGreaterEqual(data["moon_phase_pct"], 0)
        self.assertLessEqual(data["moon_phase_pct"], 100)

    def test_lunar_specific_date(self):
        r = self.client.get("/lunar?target_date=2025-01-29&lat=51.3&lon=12.0")
        self.assertEqual(r.status_code, 200)
        data = r.json()
        # Jan 29 2025 was a new moon
        self.assertLess(data["moon_phase_pct"], 10)

    def test_lunar_invalid_date(self):
        r = self.client.get("/lunar?target_date=invalid")
        self.assertEqual(r.status_code, 422)

    def test_weather_fallback(self):
        """Without OPENWEATHER_API_KEY, should return fallback values."""
        r = self.client.get("/weather?lat=51.3&lon=12.0")
        self.assertEqual(r.status_code, 200)
        data = r.json()
        self.assertIn("temp_celsius", data)
        self.assertIn("wind_speed_kmh", data)
        self.assertIn("pressure_hpa", data)

    def test_recommend_endpoint(self):
        r = self.client.post("/recommend", json={
            "target_species": "Barsch",
            "lat": 51.3,
            "lon": 12.0,
            "season": "Sommer",
        })
        self.assertEqual(r.status_code, 200)
        data = r.json()
        self.assertIn("bite_probability", data)
        self.assertIn("adjusted_probability", data)
        self.assertIn("weather", data)
        self.assertIn("lunar", data)
        self.assertIn("lure_recommendation", data)
        self.assertIn("lures", data["lure_recommendation"])
        self.assertIn("tactics", data["lure_recommendation"])
        self.assertIn("species_reasons", data)
        self.assertIn("best_times", data)

    def test_recommend_unknown_species(self):
        """Unknown species should still work with neutral scoring."""
        r = self.client.post("/recommend", json={
            "target_species": "Einhorn",
            "lat": 51.0,
            "lon": 11.0,
            "season": "Fruehling",
        })
        self.assertEqual(r.status_code, 200)
        data = r.json()
        self.assertEqual(data["species_factor"], 1.0)

    def test_predict_returns_species_preferences(self):
        """Predict endpoint should return species habitat preferences."""
        r = self.client.post("/predict", json={
            "target_species": "Zander",
            "water_temp_c": 14,
            "wind_kmh": 10,
            "pressure_hpa": 1013,
            "moon_phase": 50,
            "season": "Herbst",
        })
        self.assertEqual(r.status_code, 200)
        data = r.json()
        prefs = data.get("species_preferences")
        self.assertIsNotNone(prefs)
        self.assertIn("See", prefs["preferred_water"])
        self.assertIn("Talsperre", prefs["preferred_water"])
        self.assertEqual(prefs["preferred_depth_min"], 3)
        self.assertEqual(prefs["preferred_depth_max"], 15)
        self.assertIn("Steilkanten", prefs["preferred_structures"])
        self.assertGreater(prefs["preferred_structures"]["Steilkanten"], 0.5)

    def test_predict_unknown_species_no_preferences(self):
        """Unknown species should return null preferences."""
        r = self.client.post("/predict", json={
            "target_species": "Einhorn",
            "water_temp_c": 14,
            "wind_kmh": 10,
            "pressure_hpa": 1013,
            "moon_phase": 50,
            "season": "Herbst",
        })
        self.assertEqual(r.status_code, 200)
        data = r.json()
        self.assertIsNone(data.get("species_preferences"))

    def test_recommend_returns_species_preferences(self):
        """Recommend endpoint should include species preferences."""
        r = self.client.post("/recommend", json={
            "target_species": "Hecht",
            "lat": 51.3,
            "lon": 12.0,
            "season": "Herbst",
        })
        self.assertEqual(r.status_code, 200)
        data = r.json()
        prefs = data.get("species_preferences")
        self.assertIsNotNone(prefs)
        self.assertIn("See", prefs["preferred_water"])
        self.assertIn("Kraut", prefs["preferred_structures"])

    def test_structure_preferences_completeness(self):
        """All major species should have structure preferences."""
        major_species = ["Zander", "Hecht", "Barsch", "Karpfen", "Aal", "Forelle", "Wels", "Schleie", "Barbe", "Rapfen"]
        for species in major_species:
            r = self.client.post("/predict", json={
                "target_species": species,
                "water_temp_c": 14,
                "wind_kmh": 10,
                "pressure_hpa": 1013,
                "moon_phase": 50,
                "season": "Sommer",
            })
            data = r.json()
            prefs = data.get("species_preferences")
            self.assertIsNotNone(prefs, f"{species} should have preferences")
            self.assertGreater(len(prefs["preferred_structures"]), 0,
                             f"{species} should have structure preferences")


if __name__ == '__main__':
    unittest.main()
