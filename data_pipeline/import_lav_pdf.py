from __future__ import annotations

import argparse
import csv
import re
from pathlib import Path


PATTERN = re.compile(r"^(?P<name>[A-Za-zÄÖÜäöüß\-\s]+)\s+(?P<type>See|Fluss|Teich|Kanal)")


def parse_line(line: str) -> dict[str, str] | None:
    """Parse one extracted line and return spot fields if format matches."""
    match = PATTERN.match(line.strip())
    if not match:
        return None
    return {
        "name": match.group("name").strip(),
        "gewaesser_typ": match.group("type"),
    }


def extract_rows(pdf_path: Path) -> list[dict[str, str]]:
    import pdfplumber

    rows: list[dict[str, str]] = []
    with pdfplumber.open(pdf_path) as pdf:
        for page in pdf.pages:
            text = page.extract_text() or ""
            for line in text.splitlines():
                parsed = parse_line(line)
                if parsed:
                    rows.append({**parsed, "source_file": pdf_path.name})
    return rows


def main() -> None:
    parser = argparse.ArgumentParser(description="Extract basic spot rows from LAV PDF files")
    parser.add_argument("pdf", type=Path, help="Path to source PDF")
    parser.add_argument("--out", type=Path, default=Path("spots_extracted.csv"), help="Output CSV path")
    args = parser.parse_args()

    rows = extract_rows(args.pdf)
    args.out.parent.mkdir(parents=True, exist_ok=True)
    with args.out.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=["name", "gewaesser_typ", "source_file"])
        writer.writeheader()
        writer.writerows(rows)

    print(f"Extracted {len(rows)} rows to {args.out}")


if __name__ == "__main__":
    main()
