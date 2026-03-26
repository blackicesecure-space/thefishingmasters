import unittest

from services.ml.species_rules import (
    get_species_profile,
    compute_species_score,
    get_lure_recommendation,
    SPECIES_DB,
)


class SpeciesRulesTests(unittest.TestCase):
    def test_get_known_species(self):
        profile = get_species_profile("Zander")
        self.assertIsNotNone(profile)
        self.assertEqual(profile.name, "Zander")

    def test_get_species_case_insensitive(self):
        profile = get_species_profile("hecht")
        self.assertIsNotNone(profile)
        self.assertEqual(profile.name, "Hecht")

    def test_get_unknown_species_returns_none(self):
        profile = get_species_profile("Einhorn")
        self.assertIsNone(profile)

    def test_get_species_alias(self):
        profile = get_species_profile("Doebel")
        self.assertIsNotNone(profile)
        self.assertEqual(profile.name, "Döbel")

    def test_species_score_optimal_conditions(self):
        """Zander in autumn, 15°C water, light wind, favorable moon."""
        factor, reasons = compute_species_score(
            species="Zander",
            water_temp_c=15.0,
            wind_kmh=10.0,
            season="Herbst",
            moon_phase_pct=50.0,  # Full moon
        )
        self.assertGreater(factor, 1.0)  # Should get a bonus
        self.assertGreater(len(reasons), 0)

    def test_species_score_poor_conditions(self):
        """Karpfen in winter, 4°C water, strong wind."""
        factor, reasons = compute_species_score(
            species="Karpfen",
            water_temp_c=4.0,
            wind_kmh=35.0,
            season="Winter",
            moon_phase_pct=25.0,
        )
        self.assertLess(factor, 1.0)  # Should get penalty

    def test_species_score_clamped(self):
        """Score factor should always be between 0.3 and 1.5."""
        for species in SPECIES_DB:
            factor, _ = compute_species_score(
                species=species,
                water_temp_c=14.0,
                wind_kmh=15.0,
                season="Herbst",
                moon_phase_pct=50.0,
            )
            self.assertGreaterEqual(factor, 0.3, f"{species} factor too low")
            self.assertLessEqual(factor, 1.5, f"{species} factor too high")

    def test_unknown_species_returns_neutral(self):
        factor, reasons = compute_species_score(
            species="Einhorn",
            water_temp_c=15.0,
            wind_kmh=10.0,
            season="Herbst",
            moon_phase_pct=50.0,
        )
        self.assertEqual(factor, 1.0)

    def test_lure_recommendation_known_species(self):
        rec = get_lure_recommendation("Zander", "Herbst")
        self.assertIn("lures", rec)
        self.assertIn("tactics", rec)
        self.assertGreater(len(rec["lures"]), 0)
        self.assertGreater(len(rec["tactics"]), 0)

    def test_lure_recommendation_unknown_species(self):
        rec = get_lure_recommendation("Einhorn", "Sommer")
        self.assertIn("lures", rec)
        self.assertGreater(len(rec["lures"]), 0)

    def test_all_species_have_valid_profiles(self):
        """Sanity check: all species have reasonable data."""
        for name, profile in SPECIES_DB.items():
            self.assertGreater(profile.optimal_temp_min, -5, f"{name} temp min too low")
            self.assertLess(profile.optimal_temp_max, 35, f"{name} temp max too high")
            self.assertGreater(len(profile.lures), 0, f"{name} has no lures")
            self.assertGreater(len(profile.tactics), 0, f"{name} has no tactics")
            self.assertGreater(len(profile.best_seasons), 0, f"{name} has no seasons")


if __name__ == "__main__":
    unittest.main()
