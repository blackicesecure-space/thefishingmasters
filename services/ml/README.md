# ML Service (FastAPI)

MVP-Scope:
- `GET /health` für Monitoring
- `POST /predict` für Beißwahrscheinlichkeit

## Dateien
- `app.py`: FastAPI-App mit Baseline-Scoring
- `requirements.txt`: Python-Abhängigkeiten

## Lokal starten
```bash
cd services/ml
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app:app --reload --port 8001
```

## Beispielrequest
```bash
curl -X POST http://127.0.0.1:8001/predict \
  -H 'content-type: application/json' \
  -d '{"target_species":"Zander","water_temp_c":14,"wind_kmh":12,"pressure_hpa":1012,"moon_phase":60,"season":"Herbst"}'
```
