import unittest

from services.ml.scoring import compute_bite_probability


class ScoringTests(unittest.TestCase):
    def test_probability_is_clamped(self):
        score = compute_bite_probability(
            water_temp_c=14,
            wind_kmh=0,
            pressure_hpa=1015,
            moon_phase=55,
            season='Herbst',
        )
        self.assertLessEqual(score, 95.0)
        self.assertGreaterEqual(score, 5.0)

    def test_wind_penalizes_score(self):
        calm = compute_bite_probability(
            water_temp_c=14,
            wind_kmh=8,
            pressure_hpa=1015,
            moon_phase=55,
            season='Herbst',
        )
        windy = compute_bite_probability(
            water_temp_c=14,
            wind_kmh=40,
            pressure_hpa=1015,
            moon_phase=55,
            season='Herbst',
        )
        self.assertGreater(calm, windy)


if __name__ == '__main__':
    unittest.main()
