"""
Extract fishing spot data from LAV Sachsen-Anhalt Gewässerverzeichnis PDF.

Parses the tabular format:
    K-V-N      Gewässer/Lage                  Fischarten            ha
    1-160-01   Brüders Teich bei Gardelegen    A, H, K, S            1,53

Species are abbreviated (A=Aal, H=Hecht, K=Karpfen, etc.).
Entries can span multiple lines (continuation lines have no K-V-N prefix).
Landkreis headers appear between sections.

Usage:
    python import_lav_sa_pdf.py /path/to/gewaesserverzeichnis.pdf --out spots_sa.csv
"""

from __future__ import annotations

import argparse
import csv
import re
import subprocess
from pathlib import Path


# ── Species abbreviation mapping (from PDF page 3) ─────────────────
SPECIES_ABBREV = {
    'A':  'Aal',
    'Ä':  'Äsche',
    'Ad': 'Aland',
    'Bf': 'Bachforelle',
    'Bs': 'Bachsaibling',
    'Ba': 'Barbe',
    'B':  'Barsch',
    'Bl': 'Blei',
    'D':  'Döbel',
    'Gü': 'Güster',
    'Ha': 'Hasel',
    'H':  'Hecht',
    'K':  'Karpfen',
    'Ka': 'Karausche',
    'Pl': 'Plötze',
    'M':  'Große Maräne',
    'Ma': 'Kleine Maräne',
    'Qu': 'Quappe',
    'R':  'Rapfen',
    'Rf': 'Regenbogenforelle',
    'Ro': 'Rotfeder',
    'S':  'Schleie',
    'W':  'Wels',
    'Z':  'Zander',
}

# ── Landkreis mapping (Kreis-Nr from K-V-N first digit) ────────────
KREIS_MAP = {
    '1':  'Altmarkkreis Salzwedel',
    '2':  'Stendal',
    '3':  'Börde',
    '4':  'Jerichower Land',
    '5':  'Harz',
    '6':  'Salzlandkreis',
    '7':  'Anhalt-Bitterfeld',
    '8':  'Wittenberg',
    '9':  'Mansfeld-Südharz',
    '10': 'Saalekreis',
    '11': 'Burgenlandkreis',
    '12': 'Magdeburg',
    '13': 'Dessau-Roßlau',
    '14': 'Halle',
}

# ── Regex for entry lines ──────────────────────────────────────────
# Matches: 1-160-01  Brüders Teich bei Gardelegen    A, H, K, S    1,53
# Also:   10-290-01  ...  or  Th-500-01  ...
ENTRY_LINE = re.compile(
    r'^(?P<kvn>(?:\d+|Th)-\d+-\d+)\s+'
    r'(?P<rest>.+)$',
)

# Species pattern at end of line: comma-separated abbreviations
# e.g. "A, H, K, S" or "A, B, Bl, H, Pl, S"
SPECIES_FIELD = re.compile(
    r'(?P<species>(?:[A-ZÄ][a-zü]?,\s*)*[A-ZÄ][a-zü]?)\s+'
    r'(?P<ha>[\d]+[.,]\d+)\s*$'
)

# ha value at end of line
HA_PATTERN = re.compile(r'(?P<ha>[\d]+[.,]\d+)\s*$')


def extract_text(pdf_path: Path) -> str:
    """Extract text with layout preservation."""
    result = subprocess.run(
        ['pdftotext', '-layout', str(pdf_path), '-'],
        capture_output=True, text=True, timeout=60,
    )
    if result.returncode != 0:
        raise RuntimeError(f"pdftotext failed: {result.stderr}")
    return result.stdout.replace('\x0c', '\n')


def expand_species(abbrevs: str) -> list[str]:
    """Expand species abbreviations to full names."""
    species = []
    for abbr in re.split(r'[,\s]+', abbrevs):
        abbr = abbr.strip()
        if not abbr:
            continue
        full = SPECIES_ABBREV.get(abbr)
        if full:
            species.append(full)
    return sorted(set(species))


def derive_type(name: str) -> str:
    """Derive water body type from name."""
    n = name.lower()
    if 'talsperre' in n or 'speicher' in n:
        return 'Talsperre'
    if 'stau' in n and 'see' not in n:
        return 'Stausee'
    if 'teich' in n or 'teiche' in n:
        return 'Teich'
    if any(w in n for w in ('graben', 'kanal')):
        return 'Kanal'
    if any(w in n for w in ('see', 'kiesgrube', 'kiessee', 'tonloch',
                             'tonstich', 'kuhle', 'pfütze', 'loch',
                             'badeanstalt', 'wasserbecken', 'tagebau',
                             'klärteich')):
        return 'See'
    if any(w in n for w in ('elbe', 'saale', 'milde', 'ohre', 'jeetze',
                             'dumme', 'bode', 'ilse', 'selke', 'unstrut',
                             'havel', 'mulde', 'elster', 'luppe', 'aland',
                             'nuthe', 'fuhne', 'wipper', 'helme', 'geisel',
                             'purnitz', 'beeke', 'secantsgraben',
                             ' von ', ' bis ')):
        return 'Fluss'
    return 'See'


def parse_entries(text: str) -> list[dict]:
    """Parse all water entries from the layout-preserved text."""
    lines = text.split('\n')
    entries = []
    current = None

    for line in lines:
        stripped = line.strip()
        if not stripped:
            continue

        # Skip header lines
        if stripped.startswith('K-V-N') or stripped.startswith('K - V - N'):
            continue

        # Try to match entry line
        m = ENTRY_LINE.match(stripped)
        if m:
            # Save previous entry
            if current:
                entries.append(current)

            kvn = m.group('kvn')
            rest = m.group('rest')

            # Parse species and ha from rest
            species_str, ha_val, name_lage, regelung = _parse_rest(rest)

            kreis_nr = kvn.split('-')[0]
            landkreis = KREIS_MAP.get(kreis_nr, '')

            current = {
                'kvn': kvn,
                'name': name_lage,
                'landkreis': landkreis,
                'fischarten_raw': species_str,
                'fischarten': ','.join(expand_species(species_str)),
                'flaeche_ha': ha_val,
                'regelung': regelung,
                'gewaesser_typ': derive_type(name_lage),
                'boot_erlaubt': False,
                'beschreibung': '',
            }
            continue

        # Continuation line (no K-V-N prefix)
        if current:
            # Check for boat/regulation hints
            low = stripped.lower()
            if 'boot' in low or 'wasserfahrzeug' in low:
                current['boot_erlaubt'] = True
                if current['regelung']:
                    current['regelung'] += '; ' + stripped
                else:
                    current['regelung'] = stripped
            elif any(kw in low for kw in ('verboten', 'anfüttern', 'angeln nur',
                                           'beachten', 'hinweis', 'schonzeit',
                                           'verbot', 'lsg', 'nsg', 'nur ')):
                if current['regelung']:
                    current['regelung'] += '; ' + stripped
                else:
                    current['regelung'] = stripped
            else:
                # Could be continuation of name/location or species
                extra_species = _try_parse_species_continuation(stripped)
                if extra_species:
                    combined = current['fischarten_raw'] + ', ' + extra_species
                    current['fischarten'] = ','.join(expand_species(combined))
                    current['fischarten_raw'] = combined
                else:
                    # Continuation of name/location
                    if current['name']:
                        current['name'] += ' ' + stripped
                    else:
                        current['name'] = stripped

    # Don't forget the last entry
    if current:
        entries.append(current)

    return entries


def _parse_rest(rest: str) -> tuple[str, float | None, str, str]:
    """Parse the rest of an entry line into species, ha, name, and regulation.

    The layout format places columns roughly at:
      Name/Lage (left)  |  Fischarten (middle)  |  ha (right)

    Returns: (species_str, ha_value, name, regelung)
    """
    # Try to find ha value at end
    ha_match = HA_PATTERN.search(rest)
    ha_val = None
    if ha_match:
        ha_str = ha_match.group('ha').replace(',', '.')
        try:
            ha_val = float(ha_str)
        except ValueError:
            pass
        rest_before_ha = rest[:ha_match.start()].rstrip()
    else:
        rest_before_ha = rest.rstrip()

    # Now try to find species abbreviations
    # They appear as comma-separated capital letters, typically after the name
    # Strategy: look for a sequence like "A, B, H, K, S" pattern
    species_pattern = re.compile(
        r'(?P<species>(?:[A-ZÄ][a-zü]?(?:,\s*)){1,}[A-ZÄ][a-zü]?)\s*$'
    )
    sp_match = species_pattern.search(rest_before_ha)

    species_str = ''
    name = rest_before_ha
    regelung = ''

    if sp_match:
        species_str = sp_match.group('species').strip()
        name = rest_before_ha[:sp_match.start()].rstrip()
    else:
        # Try single species (e.g. just "K")
        single_sp = re.search(r'\s+([A-ZÄ][a-zü]?)\s*$', rest_before_ha)
        if single_sp and single_sp.group(1) in SPECIES_ABBREV:
            species_str = single_sp.group(1)
            name = rest_before_ha[:single_sp.start()].rstrip()

    # Clean up name
    name = name.strip()

    return species_str, ha_val, name, regelung


def _try_parse_species_continuation(line: str) -> str | None:
    """Check if a continuation line is just species abbreviations."""
    cleaned = line.strip()
    # Species continuation: just abbreviations like "Ro, S, Z" or "S, Z"
    if re.match(r'^(?:[A-ZÄ][a-zü]?,?\s*)+$', cleaned):
        # Verify at least one known abbreviation
        parts = re.split(r'[,\s]+', cleaned)
        known = sum(1 for p in parts if p.strip() in SPECIES_ABBREV)
        if known >= len(parts) * 0.5:
            return cleaned
    return None


def extract_rows(pdf_path: Path) -> list[dict]:
    """Extract spot rows from a LAV SA PDF file."""
    text = extract_text(pdf_path)
    entries = parse_entries(text)

    for entry in entries:
        entry['bundesland'] = 'Sachsen-Anhalt'
        entry['source_file'] = pdf_path.name

    return entries


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Extract fishing spot data from LAV SA PDF"
    )
    parser.add_argument("pdf", type=Path, help="Path to source PDF")
    parser.add_argument(
        "--out",
        type=Path,
        default=Path("spots_sa.csv"),
        help="Output CSV path",
    )
    args = parser.parse_args()

    rows = extract_rows(args.pdf)
    args.out.parent.mkdir(parents=True, exist_ok=True)

    fieldnames = [
        "kvn", "name", "landkreis", "gewaesser_typ", "flaeche_ha",
        "boot_erlaubt", "fischarten", "regelung", "bundesland",
        "source_file", "beschreibung",
    ]

    with args.out.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames, extrasaction="ignore")
        writer.writeheader()
        writer.writerows(rows)

    print(f"Extracted {len(rows)} entries to {args.out}")


if __name__ == "__main__":
    main()
