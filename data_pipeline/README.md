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

Die aktuelle MVP-Version extrahiert Spotname + Gewässertyp heuristisch; Geocoding und erweiterte Felder folgen im nächsten Schritt.
