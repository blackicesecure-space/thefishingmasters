import unittest

from data_pipeline.import_lav_pdf import parse_line


class DataPipelineTests(unittest.TestCase):
    def test_parse_line_accepts_supported_format(self):
        parsed = parse_line('Goitzschesee See')
        self.assertEqual(parsed, {'name': 'Goitzschesee', 'gewaesser_typ': 'See'})

    def test_parse_line_rejects_invalid_text(self):
        self.assertIsNone(parse_line('123 456'))


if __name__ == '__main__':
    unittest.main()
