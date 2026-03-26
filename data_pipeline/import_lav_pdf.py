"""
Extract fishing spot data from LAV (Landesanglerverband) PDF files.

Supports:
- Basic format: "Spotname See/Fluss/Teich/Kanal/Talsperre"
- Extended fields: address, regulations, fish species (where parseable)

Usage:
    python import_lav_pdf.py path/to/document.pdf --out spots.csv
"""

from __future__ import annotations

import argparse
import csv
import re
from pathlib import Path


# Pattern matches: "Name  Type" where Type is a water body classification
PATTERN = re.compile(
    r"^(?P<name>[A-Za-zÄÖÜäöüß\-\s]+)\s+"
    r"(?P<type>See|Fluss|Teich|Kanal|Talsperre|Stausee|Bach|Graben)"
)

# Extended pattern: tries to capture fish species mentions
FISH_PATTERN = re.compile(
    r"(?:Fischarten|Fischbestand|Besatz)[:\s]+"
    r"(?P<species>[A-Za-zÄÖÜäöüß,\s]+?)(?:\.|$)",
    re.IGNORECASE,
)

# Regulation hints
REGULATION_PATTERN = re.compile(
    r"(?:Regelung|Vorschrift|Bestimmung)[:\s]+"
    r"(?P<text>[^\n.]+)",
    re.IGNORECASE,
)


def parse_line(line: str) -> dict[str, str] | None:
    """Parse one extracted line and return spot fields if format matches."""
    match = PATTERN.match(line.strip())
    if not match:
        return None
    return {
        "name": match.group("name").strip(),
        "gewaesser_typ": match.group("type"),
    }


def extract_extended_info(text: str) -> dict[str, str]:
    """Extract additional info (fish species, regulations) from a text block."""
    info: dict[str, str] = {}

    fish_match = FISH_PATTERN.search(text)
    if fish_match:
        species = fish_match.group("species").strip()
        # Clean up: split by comma, strip whitespace
        species_list = [s.strip() for s in species.split(",") if s.strip()]
        info["fischarten"] = ",".join(species_list)

    reg_match = REGULATION_PATTERN.search(text)
    if reg_match:
        info["regelung"] = reg_match.group("text").strip()

    return info


def extract_rows(pdf_path: Path) -> list[dict[str, str]]:
    """
    Extract spot rows from a LAV PDF file.

    Returns a list of dicts with keys:
    name, gewaesser_typ, source_file, fischarten (optional), regelung (optional)
    """
    import pdfplumber

    rows: list[dict[str, str]] = []
    seen_names: set[str] = set()

    with pdfplumber.open(pdf_path) as pdf:
        for page in pdf.pages:
            text = page.extract_text() or ""
            lines = text.splitlines()

            for i, line in enumerate(lines):
                parsed = parse_line(line)
                if not parsed:
                    continue

                # Deduplicate
                if parsed["name"] in seen_names:
                    continue
                seen_names.add(parsed["name"])

                # Try to extract extended info from surrounding lines
                context = "\n".join(lines[max(0, i - 1):min(len(lines), i + 5)])
                extended = extract_extended_info(context)

                rows.append({
                    "name": parsed["name"],
                    "gewaesser_typ": parsed["gewaesser_typ"],
                    "source_file": pdf_path.name,
                    **extended,
                })

    return rows


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Extract basic spot rows from LAV PDF files"
    )
    parser.add_argument("pdf", type=Path, help="Path to source PDF")
    parser.add_argument(
        "--out",
        type=Path,
        default=Path("spots_extracted.csv"),
        help="Output CSV path",
    )
    args = parser.parse_args()

    rows = extract_rows(args.pdf)
    args.out.parent.mkdir(parents=True, exist_ok=True)

    # Determine all fieldnames from extracted data
    fieldnames = ["name", "gewaesser_typ", "source_file", "fischarten", "regelung"]

    with args.out.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames, extrasaction="ignore")
        writer.writeheader()
        writer.writerows(rows)

    print(f"Extracted {len(rows)} rows to {args.out}")


if __name__ == "__main__":
    main()
