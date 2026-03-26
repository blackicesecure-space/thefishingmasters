import unittest
from datetime import date

from services.ml.lunar import (
    compute_moon_phase,
    compute_solunar_periods,
    get_lunar_data,
)
from datetime import datetime, timezone


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

    def test_solunar_periods_format(self):
        majors, minors, rating = compute_solunar_periods(
            date(2026, 3, 26), 51.3, 12.0
        )
        self.assertEqual(len(majors), 2)
        self.assertEqual(len(minors), 2)
        # Check time format HH:MM
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
