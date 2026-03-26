"""
Geocoding module for fishing spots.

Uses the free Nominatim (OpenStreetMap) API to convert spot names
and location hints to latitude/longitude coordinates.

Rate-limited to 1 request per second per Nominatim usage policy.
"""

from __future__ import annotations

import time
import urllib.parse
import urllib.request
import json
from dataclasses import dataclass


NOMINATIM_BASE = "https://nominatim.openstreetmap.org/search"
USER_AGENT = "TheFishingMasters/0.1 (fishing-spot-geocoder)"
REQUEST_DELAY_S = 1.1  # >1s per Nominatim policy


@dataclass
class GeoResult:
    latitude: float
    longitude: float
    display_name: str
    confidence: float  # 0-1 based on importance


def geocode(query: str, country: str = "de") -> GeoResult | None:
    """
    Geocode a location query string.

    Args:
        query: Location name, e.g. "Goitzschesee Sachsen-Anhalt"
        country: ISO country code for bias

    Returns:
        GeoResult or None if no match found.
    """
    params = urllib.parse.urlencode({
        "q": query,
        "countrycodes": country,
        "format": "json",
        "limit": "1",
        "addressdetails": "0",
    })
    url = f"{NOMINATIM_BASE}?{params}"

    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    try:
        with urllib.request.urlopen(req, timeout=10) as resp:
            data = json.loads(resp.read().decode("utf-8"))
    except Exception as e:
        print(f"  [WARN] Geocoding failed for '{query}': {e}")
        return None

    if not data:
        return None

    hit = data[0]
    return GeoResult(
        latitude=float(hit["lat"]),
        longitude=float(hit["lon"]),
        display_name=hit.get("display_name", ""),
        confidence=float(hit.get("importance", 0.5)),
    )


def geocode_spot(name: str, gewaesser_typ: str, bundesland: str = "") -> GeoResult | None:
    """
    Try multiple query strategies to geocode a fishing spot.

    Strategy order:
    1. Full: "{name} {bundesland}" (most specific)
    2. With type: "{name} {gewaesser_typ} {bundesland}"
    3. Name only: "{name}"
    """
    queries = [
        f"{name} {bundesland}".strip(),
        f"{name} {gewaesser_typ} {bundesland}".strip(),
        name,
    ]

    for query in queries:
        result = geocode(query)
        if result and result.confidence > 0.3:
            return result
        time.sleep(REQUEST_DELAY_S)

    return None


def geocode_csv(input_path: str, output_path: str) -> None:
    """
    Read a CSV with 'name' and 'gewaesser_typ' columns,
    add 'latitude' and 'longitude' columns, write to output.
    """
    import csv

    with open(input_path, newline="", encoding="utf-8") as fin:
        reader = csv.DictReader(fin)
        rows = list(reader)

    total = len(rows)
    geocoded = 0

    for i, row in enumerate(rows):
        name = row.get("name", "")
        typ = row.get("gewaesser_typ", "")
        bundesland = row.get("bundesland", "")

        print(f"  [{i+1}/{total}] Geocoding: {name} ({typ})...")

        result = geocode_spot(name, typ, bundesland)
        if result:
            row["latitude"] = f"{result.latitude:.6f}"
            row["longitude"] = f"{result.longitude:.6f}"
            row["geocode_confidence"] = f"{result.confidence:.3f}"
            geocoded += 1
        else:
            row["latitude"] = ""
            row["longitude"] = ""
            row["geocode_confidence"] = "0"
            print(f"    -> Nicht gefunden!")

        time.sleep(REQUEST_DELAY_S)

    # Write output
    fieldnames = list(rows[0].keys()) if rows else []
    with open(output_path, "w", newline="", encoding="utf-8") as fout:
        writer = csv.DictWriter(fout, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    print(f"\nGeocoding abgeschlossen: {geocoded}/{total} Spots erfolgreich.")


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Geocode fishing spot CSV data")
    parser.add_argument("input_csv", help="Input CSV with name/gewaesser_typ columns")
    parser.add_argument("--out", default="spots_geocoded.csv", help="Output CSV path")
    args = parser.parse_args()

    geocode_csv(args.input_csv, args.out)
