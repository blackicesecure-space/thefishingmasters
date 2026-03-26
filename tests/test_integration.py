"""
Integration tests: species + scoring + lunar working together.
"""

import unittest
from datetime import date

from services.ml.scoring import compute_bite_probability
from services.ml.species_rules import (
    compute_species_score,
    get_lure_recommendation,
    get_species_profile,
    SPECIES_DB,
)
from services.ml.lunar import get_lunar_data


class IntegrationTests(unittest.TestCase):
    """Test the full scoring pipeline without network calls."""

    def test_full_scoring_pipeline_all_species(self):
        """Every species in the DB should produce a valid adjusted probability."""
        for species_name in SPECIES_DB:
            base = compute_bite_probability(
                water_temp_c=16, wind_kmh=10, pressure_hpa=1013,
                moon_phase=50, season='Sommer',
            )
            factor, reasons = compute_species_score(
                species=species_name,
                water_temp_c=16,
                wind_kmh=10,
                season='Sommer',
                moon_phase_pct=50,
            )
            adjusted = max(5.0, min(95.0, round(base * factor, 2)))

            self.assertGreaterEqual(adjusted, 5.0)
            self.assertLessEqual(adjusted, 95.0)
            self.assertIsInstance(reasons, list)
            self.assertGreater(len(reasons), 0, f"{species_name} should have reasons")

    def test_lure_recommendations_for_all_species(self):
        """Every species should return lures and tactics."""
        for species_name in SPECIES_DB:
            for season in ['Fruehling', 'Sommer', 'Herbst', 'Winter']:
                rec = get_lure_recommendation(species_name, season)
                self.assertIn('lures', rec)
                self.assertIn('tactics', rec)
                self.assertGreater(len(rec['lures']), 0)
                self.assertGreater(len(rec['tactics']), 0)

    def test_lunar_plus_scoring_consistency(self):
        """Lunar data feeds into scoring without errors."""
        d = date(2025, 6, 15)
        lunar = get_lunar_data(d, 51.3, 12.0)

        base = compute_bite_probability(
            water_temp_c=18, wind_kmh=12, pressure_hpa=1010,
            moon_phase=lunar.moon_phase_pct, season='Sommer',
        )
        factor, reasons = compute_species_score(
            species='Zander',
            water_temp_c=18,
            wind_kmh=12,
            season='Sommer',
            moon_phase_pct=lunar.moon_phase_pct,
        )

        self.assertGreaterEqual(base, 5.0)
        self.assertGreaterEqual(factor, 0.3)
        self.assertLessEqual(factor, 1.5)

    def test_unknown_species_graceful_handling(self):
        """Unknown species should return neutral factor and default lures."""
        factor, reasons = compute_species_score(
            species='Einhorn',
            water_temp_c=14,
            wind_kmh=10,
            season='Herbst',
            moon_phase_pct=50,
        )
        self.assertEqual(factor, 1.0)

        rec = get_lure_recommendation('Einhorn', 'Herbst')
        self.assertIn('lures', rec)
        self.assertEqual(rec['lures'], ['Universalkoeder'])

    def test_species_profile_completeness(self):
        """Every species profile should have all required fields filled."""
        for name, profile in SPECIES_DB.items():
            self.assertTrue(len(profile.name) > 0, f"{name} has empty name")
            self.assertTrue(len(profile.lures) > 0, f"{name} has no lures")
            self.assertTrue(len(profile.tactics) > 0, f"{name} has no tactics")
            self.assertTrue(len(profile.best_seasons) > 0, f"{name} has no seasons")
            self.assertTrue(len(profile.best_times) > 0, f"{name} has no times")
            self.assertTrue(len(profile.preferred_water) > 0, f"{name} has no water types")
            self.assertGreaterEqual(profile.moon_sensitivity, 0.0)
            self.assertLessEqual(profile.moon_sensitivity, 1.0)
            self.assertLess(profile.optimal_temp_min, profile.optimal_temp_max)

    def test_optimal_conditions_produce_high_score(self):
        """Zander at ideal conditions should score well."""
        profile = get_species_profile('Zander')
        assert profile is not None
        mid_temp = (profile.optimal_temp_min + profile.optimal_temp_max) / 2

        base = compute_bite_probability(
            water_temp_c=mid_temp, wind_kmh=5, pressure_hpa=1015,
            moon_phase=0, season='Herbst',
        )
        factor, _ = compute_species_score(
            species='Zander', water_temp_c=mid_temp, wind_kmh=5,
            season='Herbst', moon_phase_pct=0,
        )
        adjusted = base * factor
        self.assertGreater(adjusted, 40, "Ideal conditions should produce a decent score")

    def test_poor_conditions_produce_low_score(self):
        """Species in terrible conditions should score poorly."""
        base = compute_bite_probability(
            water_temp_c=2, wind_kmh=50, pressure_hpa=970,
            moon_phase=25, season='Winter',
        )
        factor, _ = compute_species_score(
            species='Karpfen', water_temp_c=2, wind_kmh=50,
            season='Winter', moon_phase_pct=25,
        )
        adjusted = base * factor
        self.assertLess(adjusted, 40, "Terrible conditions should produce a low score")


if __name__ == '__main__':
    unittest.main()
