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
