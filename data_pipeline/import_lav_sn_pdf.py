"""
Extract fishing spot data from LVSA Sachsen Gewässerordnung/Gewässerverzeichnis PDF.

Parses the two-column layout with entries like:
    D 06-101 BN Ziegeleiteich Görlitz   1,85   A,H,K,S,Wf,Z
             N51°10'45,17" E14°59'36,30"

Many entries include GPS coordinates in DMS format (N/E with degrees, minutes, seconds).
Species abbreviations differ slightly from SA (includes Wf=Weißfisch, Zw=Zwergwels, etc.).

Usage:
    python import_lav_sn_pdf.py /path/to/sachsen.pdf --out spots_sn.csv
"""

from __future__ import annotations

import argparse
import csv
import re
import subprocess
from pathlib import Path


# ── Species abbreviation mapping (Sachsen-specific) ────────────────
SPECIES_ABBREV = {
    'A':   'Aal',
    'Ä':   'Äsche',
    'B':   'Barsch',
    'Bf':  'Bachforelle',
    'Bl':  'Blei',
    'D':   'Döbel',
    'GM':  'Große Maräne',
    'Gü':  'Güster',
    'H':   'Hecht',
    'K':   'Karpfen',
    'Ka':  'Karausche',
    'KM':  'Kleine Maräne',
    'Pl':  'Plötze',
    'Qu':  'Quappe',
    'R':   'Rapfen',
    'Rf':  'Regenbogenforelle',
    'Ro':  'Rotfeder',
    'S':   'Schleie',
    'Ss':  'Bachsaibling',
    'W':   'Wels',
    'Wf':  'Weißfisch',
    'Z':   'Zander',
    'Zw':  'Zwergwels',
}

# Additional flags in entries
FLAGS = {
    'B':   'boot_erlaubt',
    'BN':  'boot_nicht_erlaubt',
    'P':   'pachtgewässer',
    'S':   'schliesssystem',
    'H':   'behindertentauglich',
    'J':   'jugendgewässer',
    'TW-TS': 'trinkwassertalsperre',
}

# ── Entry line regex ───────────────────────────────────────────────
# Matches: D 06-101 BN Ziegeleiteich Görlitz   1,85   A,H,K,S,Wf,Z
# Or:      C 01-100 BN Teichname                2,50   A,H,K,S
ENTRY_RE = re.compile(
    r'(?P<gewnr>[DC]\s?\d{2}-\d{3})\s+'
    r'(?P<flags>(?:BN|B|P|S|H|J|TW-TS|,\s*)*?)\s*'
    r'(?P<name>[A-ZÄÖÜa-zäöüß][\w\s\-\/\.\(\)„"äöüÄÖÜß,]+?)\s+'
    r'(?P<size>[\d]+[.,]\d+)\s+'
    r'(?P<species>[A-ZÄ][A-Za-zÄäÖöÜü,\s]+?)$'
)

# Simpler entry regex for entries without species on same line
ENTRY_SIMPLE_RE = re.compile(
    r'(?P<gewnr>[DC]\s?\d{2}-\d{3})\s+'
    r'(?P<flags>(?:BN|B|P|S|H|J|TW-TS|,\s*)*?)\s*'
    r'(?P<name>[A-ZÄÖÜa-zäöüß][\w\s\-\/\.\(\)„"äöüÄÖÜß,]+)'
)

# GPS coordinates in DMS format
# PDF uses Unicode curly quotes: ° (degree), \u2018 ' (min), \u201c " (sec)
GPS_RE = re.compile(
    r'N(?P<lat_deg>\d+)[°](?P<lat_min>\d+)[\'\u2018\u2019′](?P<lat_sec>[\d,\.]+)[\"\u201c\u201d″]?\s+'
    r'E(?P<lon_deg>\d+)[°](?P<lon_min>\d+)[\'\u2018\u2019′](?P<lon_sec>[\d,\.]+)[\"\u201c\u201d″]?'
)

# Size pattern
SIZE_RE = re.compile(r'(?P<val>[\d]+[.,]\d+)\s*$')


def extract_text(pdf_path: Path) -> str:
    """Extract text with layout preservation."""
    result = subprocess.run(
        ['pdftotext', '-layout', str(pdf_path), '-'],
        capture_output=True, text=True, timeout=60,
    )
    if result.returncode != 0:
        raise RuntimeError(f"pdftotext failed: {result.stderr}")
    return result.stdout.replace('\x0c', '\n')


def dms_to_decimal(deg: int, minutes: int, seconds: float) -> float:
    """Convert degrees/minutes/seconds to decimal degrees."""
    return deg + minutes / 60.0 + seconds / 3600.0


def expand_species(raw: str) -> list[str]:
    """Expand comma-separated species abbreviations."""
    species = []
    for abbr in re.split(r'[,\s]+', raw):
        abbr = abbr.strip()
        if not abbr:
            continue
        full = SPECIES_ABBREV.get(abbr)
        if full:
            species.append(full)
    return sorted(set(species))


def derive_type(name: str, is_km: bool = False) -> str:
    """Derive water body type from name."""
    n = name.lower()
    if 'talsperre' in n or 'speicher' in n:
        return 'Talsperre'
    if 'stau' in n:
        return 'Stausee'
    if 'teich' in n:
        return 'Teich'
    if any(w in n for w in ('graben', 'kanal')):
        return 'Kanal'
    if any(w in n for w in ('see', 'kiesgrube', 'kiessee', 'tongrube',
                             'tonstich', 'lache', 'loch', 'bad ',
                             'volksbad', 'freibad', 'badeteich')):
        return 'See'
    if is_km or any(w in n for w in ('elbe', 'spree', 'neiße', 'mulde',
                                      'elster', 'zwickauer', 'saale',
                                      'zschopau', 'flöha', 'pleiße')):
        return 'Fluss'
    return 'See'


def parse_entries(text: str) -> list[dict]:
    """Parse all water entries from the layout-preserved text."""
    lines = text.split('\n')
    entries: dict[str, dict] = {}  # keyed by gewnr to deduplicate
    current_gewnr = None

    # Two-column layout means multiple entries and GPS coords on same lines.
    # Strategy: first pass finds all entries, second pass matches GPS coords.

    # Pass 1: Extract all entries
    last_gewnr_on_line = {}  # line_idx -> list of gewnrs found on that line
    for line_idx, line in enumerate(lines):
        stripped = line.strip()
        if not stripped:
            continue

        gewnrs_on_line = []
        # Find all entry starts on this line
        for m in re.finditer(r'([DC]\s?\d{2}-\d{3})', stripped):
            gewnr = m.group(1).replace(' ', '')
            gewnr = gewnr[0] + ' ' + gewnr[1:]
            gewnrs_on_line.append(gewnr)

            rest = stripped[m.end():].strip()
            # Truncate rest at next entry start if there are multiple entries
            next_m = re.search(r'[DC]\s?\d{2}-\d{3}', rest)
            if next_m:
                rest = rest[:next_m.start()].strip()

            entry = _parse_entry_rest(gewnr, rest)
            if entry:
                if gewnr not in entries:
                    entries[gewnr] = entry
                    current_gewnr = gewnr
                else:
                    for k, v in entry.items():
                        if v and not entries[gewnr].get(k):
                            entries[gewnr][k] = v

        if gewnrs_on_line:
            last_gewnr_on_line[line_idx] = gewnrs_on_line

    # Pass 2: Match GPS coordinates to entries
    # GPS coords appear on lines after the entry line
    for line_idx, line in enumerate(lines):
        stripped = line.strip()
        if not stripped:
            continue

        # Find all GPS coords on this line
        for gps_match in GPS_RE.finditer(stripped):
            lat = dms_to_decimal(
                int(gps_match.group('lat_deg')),
                int(gps_match.group('lat_min')),
                float(gps_match.group('lat_sec').replace(',', '.'))
            )
            lon = dms_to_decimal(
                int(gps_match.group('lon_deg')),
                int(gps_match.group('lon_min')),
                float(gps_match.group('lon_sec').replace(',', '.'))
            )

            # Find the closest preceding entry on the same "column"
            # (GPS is indented under its entry on the same side of the page)
            gps_col = gps_match.start()
            best_gewnr = None

            # Look back up to 10 lines for the owning entry
            for prev_idx in range(line_idx - 1, max(0, line_idx - 10) - 1, -1):
                if prev_idx in last_gewnr_on_line:
                    gewnrs = last_gewnr_on_line[prev_idx]
                    # If multiple entries on that line, pick the one on the
                    # same side (left vs right column)
                    if len(gewnrs) == 1:
                        best_gewnr = gewnrs[0]
                    else:
                        # Left column entries are roughly col 0-80, right 80+
                        if gps_col < 80:
                            best_gewnr = gewnrs[0]
                        else:
                            best_gewnr = gewnrs[-1]
                    break

            if best_gewnr and best_gewnr in entries:
                if not entries[best_gewnr].get('latitude'):
                    entries[best_gewnr]['latitude'] = lat
                    entries[best_gewnr]['longitude'] = lon

    return list(entries.values())


def _parse_entry_rest(gewnr: str, rest: str) -> dict | None:
    """Parse the rest of a line after the Gewässer-Nr."""
    if not rest:
        return None

    # Parse flags
    flags_str = ''
    boot_erlaubt = False
    for flag in ('BN', 'TW-TS', 'P,B', 'P,S,', 'P,S', 'P,', 'B', 'P', 'S', 'H', 'J'):
        if rest.startswith(flag + ' ') or rest.startswith(flag + ','):
            flags_str = flag
            rest = rest[len(flag):].strip().lstrip(',').strip()
            if 'B' in flag.split(',') and 'BN' not in flag:
                boot_erlaubt = True
            break

    # Try to extract size and species from the end
    # Pattern: name ... size species
    size_val = None
    species_str = ''
    is_km = False

    # Find species at end (comma-separated uppercase letters)
    sp_match = re.search(
        r'([\d]+[.,]\d+)\s+'
        r'([A-ZÄ][A-Za-zÄäÖöÜü]*(?:\s*,\s*[A-ZÄ][A-Za-zÄäÖöÜü]*)+)\s*$',
        rest
    )
    if sp_match:
        size_str = sp_match.group(1).replace(',', '.')
        try:
            size_val = float(size_str)
        except ValueError:
            pass
        species_str = sp_match.group(2)
        name = rest[:sp_match.start()].strip()
    else:
        # Try just size at end
        size_match = re.search(r'([\d]+[.,]\d+)\s*$', rest)
        if size_match:
            size_str = size_match.group(1).replace(',', '.')
            try:
                size_val = float(size_str)
            except ValueError:
                pass
            name = rest[:size_match.start()].strip()
        else:
            name = rest.strip()

    # Clean up name
    name = name.strip().rstrip(',').strip()
    if not name or len(name) < 2:
        return None

    # Detect km vs ha (for Fließgewässer)
    # In the context, rivers show km instead of ha

    return {
        'gewnr': gewnr,
        'name': name,
        'flags': flags_str,
        'flaeche_ha': size_val,
        'boot_erlaubt': boot_erlaubt,
        'fischarten': ','.join(expand_species(species_str)) if species_str else '',
        'gewaesser_typ': derive_type(name, is_km),
        'regelung': '',
        'latitude': None,
        'longitude': None,
        'beschreibung': '',
    }


def extract_rows(pdf_path: Path) -> list[dict]:
    """Extract spot rows from a Sachsen PDF file."""
    text = extract_text(pdf_path)
    entries = parse_entries(text)

    for entry in entries:
        entry['bundesland'] = 'Sachsen'
        entry['source_file'] = pdf_path.name

    return entries


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Extract fishing spot data from Sachsen Gewässerverzeichnis PDF"
    )
    parser.add_argument("pdf", type=Path, help="Path to source PDF")
    parser.add_argument(
        "--out",
        type=Path,
        default=Path("spots_sn.csv"),
        help="Output CSV path",
    )
    args = parser.parse_args()

    rows = extract_rows(args.pdf)
    args.out.parent.mkdir(parents=True, exist_ok=True)

    fieldnames = [
        "gewnr", "name", "gewaesser_typ", "flaeche_ha", "boot_erlaubt",
        "fischarten", "regelung", "latitude", "longitude",
        "bundesland", "source_file", "beschreibung",
    ]

    with args.out.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames, extrasaction="ignore")
        writer.writeheader()
        writer.writerows(rows)

    print(f"Extracted {len(rows)} entries to {args.out}")
    with_gps = sum(1 for r in rows if r.get('latitude'))
    with_species = sum(1 for r in rows if r.get('fischarten'))
    print(f"  With GPS: {with_gps}")
    print(f"  With species: {with_species}")


if __name__ == "__main__":
    main()
