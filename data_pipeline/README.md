# LAV PDF Import Pipeline (MVP)

Minimaler Startpunkt für die Extraktion von Gewässerdaten aus LAV-PDFs.

## Setup
```bash
cd data_pipeline
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

## Nutzung
```bash
python import_lav_pdf.py /pfad/zur/lav_datei.pdf --out output/spots.csv
```

## Aktueller Parser-Umfang
- Extrahiert heuristisch:
  - Spotname
  - Gewässertyp (`See`, `Fluss`, `Teich`, `Kanal`)
  - Quell-Dateiname

## Tests
```bash
cd /workspace/thefishingmasters
python3 -m unittest tests/test_data_pipeline.py -v
```

Die aktuelle MVP-Version ist absichtlich schlank; Geocoding, Feldmapping und Datenvalidierung werden im nächsten Schritt erweitert.


## Interne Parser-API
- `parse_line(...)` validiert und extrahiert Spotname/Gewässertyp pro Textzeile.
- `extract_rows(...)` aggregiert über alle Seiten und hängt `source_file` an.
Die aktuelle MVP-Version extrahiert Spotname + Gewässertyp heuristisch; Geocoding und erweiterte Felder folgen im nächsten Schritt.
