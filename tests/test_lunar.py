import unittest
from datetime import date, datetime, timezone

from services.ml.lunar import (
    compute_moon_phase,
    compute_solunar_periods,
    get_lunar_data,
    _julian_day,
)


class LunarTests(unittest.TestCase):
    def test_moon_phase_returns_valid_range(self):
        dt = datetime(2026, 3, 26, 12, 0, tzinfo=timezone.utc)
        pct, name, illum = compute_moon_phase(dt)
        self.assertGreaterEqual(pct, 0)
        self.assertLessEqual(pct, 100)
        self.assertGreaterEqual(illum, 0)
        self.assertLessEqual(illum, 100)
        self.assertIsInstance(name, str)
        self.assertGreater(len(name), 0)

    def test_moon_phase_name_is_german(self):
        dt = datetime(2026, 1, 1, 12, 0, tzinfo=timezone.utc)
        _, name, _ = compute_moon_phase(dt)
        valid_names = [
            "Neumond", "Zunehmende Sichel", "Erstes Viertel",
            "Zunehmender Mond", "Vollmond", "Abnehmender Mond",
            "Letztes Viertel", "Abnehmende Sichel",
        ]
        self.assertIn(name, valid_names)

    def test_julian_day_known_value(self):
        """J2000.0 = JD 2451545.0 at Jan 1.5, 2000 (noon UTC)."""
        dt = datetime(2000, 1, 1, 12, 0, tzinfo=timezone.utc)
        jd = _julian_day(dt)
        self.assertAlmostEqual(jd, 2451545.0, places=1)

    def test_known_new_moon(self):
        """Jan 29, 2025 was a known new moon – phase should be near 0 or 100."""
        dt = datetime(2025, 1, 29, 12, 14, tzinfo=timezone.utc)
        pct, name, illum = compute_moon_phase(dt)
        # Should be near new moon (0 or 100)
        near_new = pct < 8 or pct > 92
        self.assertTrue(near_new, f"Expected near new moon, got phase_pct={pct}")
        self.assertLess(illum, 15, f"Expected low illumination at new moon, got {illum}")

    def test_known_full_moon(self):
        """Feb 12, 2025 was a known full moon – phase should be near 50."""
        dt = datetime(2025, 2, 12, 13, 53, tzinfo=timezone.utc)
        pct, name, illum = compute_moon_phase(dt)
        self.assertAlmostEqual(pct, 50, delta=8,
                               msg=f"Expected near full moon (50), got {pct}")
        self.assertGreater(illum, 85, f"Expected high illumination at full moon, got {illum}")

    def test_full_moon_not_reported_as_new(self):
        """Regression: full moon must not be reported as new moon."""
        # Test several known full moons
        full_moons = [
            datetime(2025, 2, 12, 13, 0, tzinfo=timezone.utc),
            datetime(2025, 7, 10, 20, 0, tzinfo=timezone.utc),
            datetime(2025, 12, 4, 23, 0, tzinfo=timezone.utc),
        ]
        for dt in full_moons:
            pct, name, _ = compute_moon_phase(dt)
            self.assertGreater(pct, 35, f"{dt.date()}: phase_pct={pct}, expected >35")
            self.assertLess(pct, 65, f"{dt.date()}: phase_pct={pct}, expected <65")

    def test_solunar_periods_format(self):
        majors, minors, rating = compute_solunar_periods(
            date(2026, 3, 26), 51.3, 12.0
        )
        self.assertEqual(len(majors), 2)
        self.assertEqual(len(minors), 2)
        for start, end in majors + minors:
            self.assertRegex(start, r"^\d{2}:\d{2}$")
            self.assertRegex(end, r"^\d{2}:\d{2}$")
        self.assertGreaterEqual(rating, 1)
        self.assertLessEqual(rating, 5)

    def test_get_lunar_data_returns_complete(self):
        data = get_lunar_data(date(2026, 6, 15), 51.3, 12.0)
        self.assertEqual(data.date, "2026-06-15")
        self.assertGreaterEqual(data.moon_phase_pct, 0)
        self.assertLessEqual(data.moon_phase_pct, 100)
        self.assertGreater(len(data.solunar_major_1), 0)
        self.assertGreater(len(data.solunar_minor_1), 0)

    def test_lunar_data_to_dict(self):
        data = get_lunar_data(date(2026, 3, 26))
        d = data.to_dict()
        self.assertIn("moon_phase_pct", d)
        self.assertIn("solunar_rating", d)
        self.assertIsInstance(d, dict)


if __name__ == "__main__":
    unittest.main()
