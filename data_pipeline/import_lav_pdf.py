"""
Extract fishing spot data from LAVT (Landesanglerverband Thüringen) PDF files.

Parses the numbered entry format used in the Thüringer Gewässerverbund directory:
    1. Speicher Dachwig (B) • 68 ha
    71. Saale - 21,4 km, 65.5 ha
    130. Apfelstädt • 20 km, ca. 17 ha

Usage:
    python import_lav_pdf.py path/to/document.pdf --out spots.csv
    python import_lav_pdf.py path/to/document.pdf --bundesland Thueringen
"""

from __future__ import annotations

import argparse
import csv
import re
import subprocess
from pathlib import Path


# ── Known fish species for lookup matching in prose text ──────────────
KNOWN_SPECIES = {
    "Zander", "Hecht", "Barsch", "Karpfen", "Aal", "Schleie",
    "Forelle", "Bachforelle", "Regenbogenforelle", "Wels",
    "Rapfen", "Döbel", "Barbe", "Plötze", "Rotfeder", "Blei",
    "Karausche", "Giebel", "Gründling", "Hasel", "Äsche",
    "Weißfisch", "Zwergwels", "Güster", "Ukelei", "Quappe",
    "Schlammpeitzger", "Nase", "Elritze", "Bachsaibling",
}

# Also match plural/declined forms (German genitive/dative endings)
# Zandern → Zander, Karpfen → Karpfen, Barschen → Barsch, Hechten → Hecht
# Schleien → Schleie, Plötzen → Plötze, Forellen → Forelle
_SPECIES_PATTERN = re.compile(
    r'\b(' + '|'.join(re.escape(s) for s in sorted(KNOWN_SPECIES, key=len, reverse=True)) + r')(?:n|en|s|nen)?\b',
    re.IGNORECASE,
)

# ── Entry header pattern ─────────────────────────────────────────────
# Matches lines like:
#   1. Speicher Dachwig (B) • 68 ha
#   71. Saale - 21,4 km, 65.5 ha
#   130. Apfelstädt • 20 km, ca. 17 ha
#   14. Triftsee – Gemarkung Mittelhausen 15,72 ha
#   137. Linderbach von Gemarkung Linderbach bis Einmündung
ENTRY_HEADER = re.compile(
    r'^(?P<nr>\d+)\.\s+'
    r'(?P<rest>.+)',
    re.MULTILINE,
)

# Area/length extraction from the "rest" portion
AREA_PATTERN = re.compile(
    r'(?:ca\.\s*)?(?P<val>[\d]+[.,]?\d*)\s*(?P<unit>ha|km)',
    re.IGNORECASE,
)

# Boot flag
BOOT_FLAG = re.compile(r'\(B\)')


def extract_text_pdftotext(pdf_path: Path) -> str:
    """Extract text from PDF using pdftotext (poppler-utils)."""
    result = subprocess.run(
        ['pdftotext', str(pdf_path), '-'],
        capture_output=True, text=True, timeout=30,
    )
    if result.returncode != 0:
        raise RuntimeError(f"pdftotext failed: {result.stderr}")
    # Replace form-feed characters (page breaks) with newlines
    return result.stdout.replace('\x0c', '\n')


def derive_type(name: str, has_km: bool) -> str:
    """Derive water body type from name and unit."""
    n = name.lower()
    if 'talsperre' in n:
        return 'Talsperre'
    if 'speicher' in n:
        return 'Talsperre'
    if 'stau' in n and 'see' not in n:
        return 'Stausee'
    if 'teich' in n:
        return 'Teich'
    if 'graben' in n or 'flutgraben' in n or 'flutkanal' in n:
        return 'Kanal'
    if any(w in n for w in ('kiessee', 'see', 'bad', 'seeloch')):
        return 'See'
    if has_km:
        return 'Fluss'
    if any(w in n for w in ('saale', 'gera', 'ilm', 'unstrut', 'helme',
                             'wipper', 'nesse', 'apfelstädt', 'hörsel',
                             'vippach', 'linderbach', 'schnauder', 'luhne',
                             'fließstrecke')):
        return 'Fluss'
    return 'See'


def extract_species(text: str) -> list[str]:
    """Extract fish species mentioned in a text block."""
    found = set()
    for m in _SPECIES_PATTERN.finditer(text):
        # Normalize to title case from KNOWN_SPECIES
        raw = m.group(1)
        for sp in KNOWN_SPECIES:
            if sp.lower() == raw.lower():
                found.add(sp)
                break
    return sorted(found)


def parse_entries(text: str) -> list[dict]:
    """Parse all numbered entries from the extracted PDF text."""
    # Find all entry header positions
    headers = list(ENTRY_HEADER.finditer(text))

    # Filter out sub-entries (numbered lists within entries like "1.", "2.", "3."
    # that appear inside entry 36 or 134). We keep only entries with nr >= 1
    # that are actual top-level entries. Sub-entries have low numbers and appear
    # between higher-numbered entries.
    filtered = []
    for i, h in enumerate(headers):
        nr = int(h.group('nr'))
        # Skip if this looks like a sub-numbering within an entry:
        # - nr <= 3 AND it's not the very first entries (which start the doc)
        # - Check: previous filtered entry has a higher number
        if nr <= 3 and filtered:
            prev_nr = filtered[-1][0]
            if prev_nr > 3:
                # This is a sub-entry, skip it
                continue
        filtered.append((nr, h))

    entries = []
    for idx, (nr, match) in enumerate(filtered):
        rest = match.group('rest')

        # Get the context block: text from this header to the next header
        start_pos = match.end()
        if idx + 1 < len(filtered):
            end_pos = filtered[idx + 1][1].start()
        else:
            end_pos = len(text)
        context = text[match.start():end_pos]

        # Extract boot flag from header line
        boot = bool(BOOT_FLAG.search(rest))

        # Extract area/length
        area_matches = list(AREA_PATTERN.finditer(context))
        flaeche_ha = None
        has_km = False
        for am in area_matches:
            val_str = am.group('val').replace(',', '.')
            try:
                val = float(val_str)
            except ValueError:
                continue
            unit = am.group('unit').lower()
            if unit == 'ha' and flaeche_ha is None:
                flaeche_ha = val
            if unit == 'km':
                has_km = True

        # Extract name: everything before (B), •, -, area pattern, or end
        # Clean the "rest" to get just the name
        name = rest
        # Remove (B) flag
        name = re.sub(r'\s*\(B\)\s*', ' ', name)
        # Remove area/length info (everything from first • or - followed by numbers)
        name = re.split(r'\s*[•·]\s*', name)[0]
        name = re.split(r'\s*[-–]\s*(?=\d)', name)[0]
        # Remove trailing area if directly appended (e.g. "15,72 ha")
        name = re.sub(r'\s+(?:ca\.\s*)?[\d.,]+\s*(?:ha|km).*$', '', name)
        # Clean up
        name = name.strip().rstrip('.')
        # Remove quotes
        name = name.replace('„', '').replace('"', '').replace('"', '')

        if not name:
            continue

        # Derive water type
        gewaesser_typ = derive_type(name, has_km)

        # Extract fish species from context
        species = extract_species(context)

        # Extract regulation hints
        regelung_parts = []
        if boot:
            regelung_parts.append('Bootsangeln erlaubt')
        schonzeit_match = re.search(
            r'Schonzeit\s+(?:für\s+)?(\w+)\s+vom\s+([\d.]+)\s+bis\s+([\d.]+)',
            context, re.IGNORECASE,
        )
        if schonzeit_match:
            regelung_parts.append(
                f"Schonzeit {schonzeit_match.group(1)}: "
                f"{schonzeit_match.group(2)} - {schonzeit_match.group(3)}"
            )
        regelung = '; '.join(regelung_parts) if regelung_parts else ''

        # Build description from first 2 sentences of context (after header line)
        desc_text = context[context.find('\n') + 1:].strip() if '\n' in context else ''
        # Take first ~300 chars as description
        if len(desc_text) > 300:
            # Cut at last space before 300
            cut = desc_text[:300].rfind(' ')
            desc_text = desc_text[:cut] + '...' if cut > 0 else desc_text[:300]

        entries.append({
            'nr': nr,
            'name': name,
            'gewaesser_typ': gewaesser_typ,
            'flaeche_ha': flaeche_ha,
            'boot_erlaubt': boot,
            'fischarten': ','.join(species),
            'regelung': regelung,
            'beschreibung': desc_text.replace('\n', ' '),
        })

    return entries


def extract_rows(pdf_path: Path, bundesland: str = 'Thueringen') -> list[dict]:
    """
    Extract spot rows from a LAVT PDF file.

    Returns a list of dicts ready for CSV export.
    """
    text = extract_text_pdftotext(pdf_path)
    entries = parse_entries(text)

    for entry in entries:
        entry['bundesland'] = bundesland
        entry['source_file'] = pdf_path.name

    return entries


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Extract fishing spot data from LAVT PDF files"
    )
    parser.add_argument("pdf", type=Path, help="Path to source PDF")
    parser.add_argument(
        "--out",
        type=Path,
        default=Path("spots_extracted.csv"),
        help="Output CSV path",
    )
    parser.add_argument(
        "--bundesland",
        default="Thueringen",
        help="Bundesland name for all extracted spots",
    )
    args = parser.parse_args()

    rows = extract_rows(args.pdf, args.bundesland)
    args.out.parent.mkdir(parents=True, exist_ok=True)

    fieldnames = [
        "nr", "name", "gewaesser_typ", "flaeche_ha", "boot_erlaubt",
        "fischarten", "regelung", "bundesland", "source_file", "beschreibung",
    ]

    with args.out.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames, extrasaction="ignore")
        writer.writeheader()
        writer.writerows(rows)

    print(f"Extracted {len(rows)} entries to {args.out}")


if __name__ == "__main__":
    main()
