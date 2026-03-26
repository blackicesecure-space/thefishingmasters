import unittest

from services.ml.weather_client import (
    WeatherData,
    _cache_key,
    _get_cached,
    _set_cache,
    clear_cache,
    _FALLBACK,
)


class WeatherClientTests(unittest.TestCase):
    def setUp(self):
        clear_cache()

    def test_fallback_has_reasonable_defaults(self):
        self.assertGreater(_FALLBACK.temp_celsius, 0)
        self.assertGreater(_FALLBACK.pressure_hpa, 900)
        self.assertLessEqual(_FALLBACK.wind_speed_kmh, 50)

    def test_cache_key_rounds_coordinates(self):
        key1 = _cache_key(51.624, 12.346)
        key2 = _cache_key(51.625, 12.349)
        self.assertEqual(key1, key2)  # Both round to 51.62,12.35

    def test_cache_set_and_get(self):
        data = WeatherData(
            temp_celsius=18.5,
            wind_speed_kmh=12.0,
            wind_direction=180,
            pressure_hpa=1015.0,
            cloud_cover=40,
            humidity=55,
            precipitation_mm=0.0,
            description="Leicht bewölkt",
            icon="02d",
        )
        _set_cache(51.5, 12.0, data)
        cached = _get_cached(51.5, 12.0)
        self.assertIsNotNone(cached)
        self.assertEqual(cached.temp_celsius, 18.5)
        self.assertEqual(cached.wind_speed_kmh, 12.0)

    def test_cache_miss_returns_none(self):
        result = _get_cached(99.0, 99.0)
        self.assertIsNone(result)

    def test_weather_data_to_dict(self):
        data = _FALLBACK
        d = data.to_dict()
        self.assertIn("temp_celsius", d)
        self.assertIn("pressure_hpa", d)
        self.assertIsInstance(d, dict)


if __name__ == "__main__":
    unittest.main()
