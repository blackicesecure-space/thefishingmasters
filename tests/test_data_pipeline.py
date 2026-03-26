import unittest

from data_pipeline.import_lav_pdf import parse_line, extract_extended_info


class DataPipelineTests(unittest.TestCase):
    def test_parse_line_accepts_supported_format(self):
        parsed = parse_line('Goitzschesee See')
        self.assertEqual(parsed, {'name': 'Goitzschesee', 'gewaesser_typ': 'See'})

    def test_parse_line_rejects_invalid_text(self):
        self.assertIsNone(parse_line('123 456'))

    def test_parse_line_accepts_talsperre(self):
        parsed = parse_line('Bleilochtalsperre Talsperre')
        self.assertEqual(parsed, {'name': 'Bleilochtalsperre', 'gewaesser_typ': 'Talsperre'})

    def test_parse_line_accepts_umlauts(self):
        parsed = parse_line('Süßer See See')
        self.assertEqual(parsed, {'name': 'Süßer See', 'gewaesser_typ': 'See'})

    def test_parse_line_accepts_fluss(self):
        parsed = parse_line('Saale bei Halle Fluss')
        self.assertEqual(parsed, {'name': 'Saale bei Halle', 'gewaesser_typ': 'Fluss'})

    def test_extract_extended_info_fish(self):
        text = "Fischarten: Zander, Barsch, Hecht. Weitere Informationen."
        info = extract_extended_info(text)
        self.assertEqual(info["fischarten"], "Zander,Barsch,Hecht")

    def test_extract_extended_info_no_match(self):
        info = extract_extended_info("Keine relevanten Daten hier.")
        self.assertEqual(info, {})


if __name__ == '__main__':
    unittest.main()
