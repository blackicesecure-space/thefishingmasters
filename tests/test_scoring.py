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

    def test_pressure_affects_score(self):
        optimal = compute_bite_probability(
            water_temp_c=14, wind_kmh=10, pressure_hpa=1015,
            moon_phase=50, season='Sommer',
        )
        low_pressure = compute_bite_probability(
            water_temp_c=14, wind_kmh=10, pressure_hpa=970,
            moon_phase=50, season='Sommer',
        )
        self.assertGreater(optimal, low_pressure)

    def test_extreme_cold_reduces_score(self):
        warm = compute_bite_probability(
            water_temp_c=14, wind_kmh=10, pressure_hpa=1015,
            moon_phase=50, season='Sommer',
        )
        cold = compute_bite_probability(
            water_temp_c=2, wind_kmh=10, pressure_hpa=1015,
            moon_phase=50, season='Winter',
        )
        self.assertGreater(warm, cold)

    def test_all_seasons_produce_valid_scores(self):
        for season in ['Fruehling', 'Sommer', 'Herbst', 'Winter']:
            score = compute_bite_probability(
                water_temp_c=14, wind_kmh=10, pressure_hpa=1013,
                moon_phase=50, season=season,
            )
            self.assertGreaterEqual(score, 5.0)
            self.assertLessEqual(score, 95.0)

    def test_moon_phase_boundaries(self):
        """Moon phase 0 and 100 should both produce valid scores."""
        for mp in [0, 25, 50, 75, 100]:
            score = compute_bite_probability(
                water_temp_c=14, wind_kmh=10, pressure_hpa=1013,
                moon_phase=mp, season='Herbst',
            )
            self.assertGreaterEqual(score, 5.0)
            self.assertLessEqual(score, 95.0)


if __name__ == '__main__':
    unittest.main()
