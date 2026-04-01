"""
Fast batch geocoder for Sachsen-Anhalt fishing spots.

Strategy: Extract the place/town name from each entry's name field
(e.g. "bei Gardelegen" -> "Gardelegen") and geocode the town once.
Then reuse the same coordinates for all spots near that town.

This reduces ~1140 spots to ~300 unique town lookups.
"""

from __future__ import annotations

import csv
import json
import re
import time
import urllib.parse
import urllib.request
from pathlib import Path


NOMINATIM_BASE = "https://nominatim.openstreetmap.org/search"
USER_AGENT = "TheFishingMasters/0.1 (fishing-spot-geocoder)"
REQUEST_DELAY_S = 1.1

# Cache: location query -> (lat, lon) or None
_geocache: dict[str, tuple[float, float] | None] = {}


def _nominatim_search(query: str) -> tuple[float, float] | None:
    """Single Nominatim search, returns (lat, lon) or None."""
    if query in _geocache:
        return _geocache[query]

    params = urllib.parse.urlencode({
        "q": query,
        "countrycodes": "de",
        "format": "json",
        "limit": "1",
    })
    url = f"{NOMINATIM_BASE}?{params}"
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})

    try:
        with urllib.request.urlopen(req, timeout=10) as resp:
            data = json.loads(resp.read().decode("utf-8"))
    except Exception as e:
        print(f"  [WARN] Request failed for '{query}': {e}")
        _geocache[query] = None
        return None

    time.sleep(REQUEST_DELAY_S)

    if not data:
        _geocache[query] = None
        return None

    result = (float(data[0]["lat"]), float(data[0]["lon"]))
    _geocache[query] = result
    return result


def _extract_place(name: str) -> str | None:
    """Extract place/town name from a water body name."""
    # Patterns: "bei Gardelegen", "in Bruckdorf", "in der Gemarkung X"
    m = re.search(
        r'(?:bei|in|am|an|vor|hinter|nahe|neben|zwischen)\s+'
        r'(?:der\s+(?:Ortslage|Gemarkung)\s+)?'
        r'([A-ZÄÖÜ][a-zäöüß]+(?:[/-][A-ZÄÖÜ][a-zäöüß]+)?)',
        name,
    )
    if m:
        place = m.group(1)
        # Filter out non-places
        if place.lower() not in ('der', 'die', 'den', 'dem', 'des', 'ein',
                                  'mündung', 'autobahnbrücke', 'landesgrenze',
                                  'straßenbrücke', 'brücke'):
            return place

    # Try compound names: "Dorfteich Steimke" -> "Steimke"
    prefixes = ('Dorfteich', 'Teich', 'Kiessee', 'Kiesgrube', 'Tonloch',
                'Tonstich', 'Stadtgraben', 'Stausee', 'Speicher', 'Talsperre',
                'Parkteich', 'Badekuhle', 'Wasserspeicher', 'Mühlteich',
                'Försterteich', 'Beregnungsteich', 'Schloßteich', 'Angelteich',
                'Angelteiche', 'Anglerteiche', 'Klärteiche', 'Pfütze')
    for prefix in prefixes:
        if name.startswith(prefix + ' '):
            rest = name[len(prefix):].strip()
            word = rest.split()[0] if rest else ''
            if word and word[0].isupper() and len(word) > 2:
                return word

    return None


def _extract_river_place(name: str) -> str | None:
    """For river entries like 'Milde von Gardelegen-Isenschnibbe bis Kalbe'."""
    m = re.search(r'(?:von|ab)\s+([A-ZÄÖÜ][a-zäöüß]+)', name)
    if m:
        return m.group(1)
    m = re.search(r'(?:bis)\s+([A-ZÄÖÜ][a-zäöüß]+)', name)
    if m:
        return m.group(1)
    return None


def geocode_entry(name: str, landkreis: str) -> tuple[float, float] | None:
    """Geocode a single SA fishing spot entry."""
    # Strategy 1: Extract place name and geocode with Landkreis context
    place = _extract_place(name)
    if place:
        result = _nominatim_search(f"{place} {landkreis} Sachsen-Anhalt")
        if result:
            return result
        result = _nominatim_search(f"{place} Sachsen-Anhalt")
        if result:
            return result

    # Strategy 2: For rivers, extract start/end place
    river_place = _extract_river_place(name)
    if river_place and river_place != place:
        result = _nominatim_search(f"{river_place} {landkreis} Sachsen-Anhalt")
        if result:
            return result

    # Strategy 3: Try the full water body name
    result = _nominatim_search(f"{name} Sachsen-Anhalt")
    if result:
        return result

    # Strategy 4: Try just with Landkreis
    # Clean name: remove "von X bis Y" parts
    clean = re.sub(r'\s+von\s+.*$', '', name)
    clean = re.sub(r'\s+\d.*$', '', clean)  # Remove trailing numbers
    if clean != name:
        result = _nominatim_search(f"{clean} {landkreis} Sachsen-Anhalt")
        if result:
            return result

    return None


def geocode_csv(input_csv: Path, output_csv: Path) -> None:
    """Batch geocode SA spots CSV."""
    with open(input_csv, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        rows = list(reader)

    total = len(rows)
    found = 0

    for i, row in enumerate(rows):
        name = row.get("name", "")
        landkreis = row.get("landkreis", "")

        result = geocode_entry(name, landkreis)
        if result:
            row["latitude"] = f"{result[0]:.6f}"
            row["longitude"] = f"{result[1]:.6f}"
            found += 1
        else:
            row["latitude"] = ""
            row["longitude"] = ""

        if (i + 1) % 50 == 0:
            print(f"  [{i+1}/{total}] geocoded, {found} found so far "
                  f"({len(_geocache)} cached queries)")

    # Write output
    fieldnames = list(rows[0].keys()) if rows else []
    if "latitude" not in fieldnames:
        fieldnames.extend(["latitude", "longitude"])
    with open(output_csv, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    print(f"\nGeocoding done: {found}/{total} spots ({found/total*100:.0f}%)")
    print(f"Unique queries: {len(_geocache)} ({sum(1 for v in _geocache.values() if v)} found)")


if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("input_csv", type=Path)
    parser.add_argument("--out", type=Path, default=Path("spots_sa_geo.csv"))
    args = parser.parse_args()
    geocode_csv(args.input_csv, args.out)
