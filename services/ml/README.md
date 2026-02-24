# ML Service (FastAPI)

## MVP-Scope
- `GET /health` für Monitoring
- `POST /predict` für Beißwahrscheinlichkeit

## Dateien
- `app.py`: FastAPI-App
- `scoring.py`: testbares Baseline-Scoring
- `requirements.txt`: Python-Abhängigkeiten

## Lokal starten
**macOS/Linux (bash/zsh)**
```bash
cd services/ml
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app:app --reload --port 8001
```

**Windows (PowerShell)**
```powershell
Set-Location services/ml
py -m venv .venv
.\.venv\Scripts\Activate.ps1
py -m pip install -r .\requirements.txt
py -m uvicorn app:app --reload --port 8001
```

## Beispielrequest
```bash
curl -X POST http://127.0.0.1:8001/predict \
  -H 'content-type: application/json' \
  -d '{"target_species":"Zander","water_temp_c":14,"wind_kmh":12,"pressure_hpa":1012,"moon_phase":60,"season":"Herbst"}'
```

## Tests
**macOS/Linux (bash/zsh)**
```bash
cd /workspace/thefishingmasters
python3 -m unittest tests/test_scoring.py -v
python3 -m unittest discover -s tests -t . -p 'test_*.py'
```

**Windows (PowerShell)**
```powershell
Set-Location <REPO_ROOT>
py -m unittest tests/test_scoring.py -v
py -m unittest discover -s tests -t . -p "test_*.py"
```

## Import-Hinweis
- `app.py` unterstützt direkten Start im Service-Ordner und Paket-Importe (relative/absolute Fallback-Imports).
- Falls du aus dem Repo-Root startest, verwende alternativ:

```bash
uvicorn services.ml.app:app --reload --port 8001
```


## Troubleshooting (Windows)
- `source` ist ein Bash-Befehl und funktioniert nicht in PowerShell.
- Nutze stattdessen `\.\.venv\Scripts\Activate.ps1` sowie `py -m ...` Kommandos aus den Blöcken oben.
- Falls `requirements.txt` nicht gefunden wird: mit `Get-Location` prüfen und in `services/ml` wechseln.

