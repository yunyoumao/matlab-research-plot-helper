"""Validate public assets for matlab-research-plot-helper.

The script uses only the Python standard library. It checks expected files,
generated outputs, and obvious public-safety problems.
"""

from __future__ import annotations

import csv
import re
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]

EXPECTED_FILES = [
    "README.md",
    "LICENSE",
    "CONTRIBUTING.md",
    "CODE_OF_CONDUCT.md",
    ".gitignore",
    ".gitattributes",
    "matlab/applyResearchPlotStyle.m",
    "matlab/exportResearchFigure.m",
    "matlab/generateSyntheticData.m",
    "matlab/demoTimeSeriesPlot.m",
    "matlab/demoFrequencyResponsePlot.m",
    "matlab/demoComparisonPlot.m",
    "matlab/runAllDemos.m",
    "data/synthetic_timeseries.csv",
    "data/synthetic_frequency_response.csv",
    "docs/plotting-guidelines.md",
]

EXPECTED_OUTPUTS = [
    "examples/before/timeseries_before.png",
    "examples/before/timeseries_before.pdf",
    "examples/before/timeseries_before.svg",
    "examples/after/timeseries_after.png",
    "examples/after/timeseries_after.pdf",
    "examples/after/timeseries_after.svg",
    "examples/before/frequency_response_before.png",
    "examples/before/frequency_response_before.pdf",
    "examples/before/frequency_response_before.svg",
    "examples/after/frequency_response_after.png",
    "examples/after/frequency_response_after.pdf",
    "examples/after/frequency_response_after.svg",
    "examples/before/comparison_before.png",
    "examples/before/comparison_before.pdf",
    "examples/before/comparison_before.svg",
    "examples/after/comparison_after.png",
    "examples/after/comparison_after.pdf",
    "examples/after/comparison_after.svg",
]

TEXT_EXTENSIONS = {".md", ".m", ".py", ".csv", ".gitignore", ".gitattributes"}

SENSITIVE_PATTERNS = {
    "email": re.compile(r"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b"),
    "phone": re.compile(r"\b(?:1[3-9]\d{9}|\+?\d{1,3}[-\s]\d{3,4}[-\s]\d{4})\b"),
    "windows_path": re.compile(r"\b[A-Za-z]:\\"),
    "credential": re.compile(
        r"(?i)\b("
        + r"api[_-]?"
        + "key"
        + "|"
        + "sec"
        + "ret"
        + "|"
        + "to"
        + "ken"
        + r")\b"
    ),
    "private_terms": re.compile(
        r"(?i)\b("
        + "Air"
        + "Liquide"
        + "|pass"
        + "port"
        + "|hu"
        + "kou"
        + r")\b|"
        + "户"
        + "口|护"
        + "照|籍"
        + "贯"
    ),
}

FORBIDDEN_PUBLIC_NAMES = {
    "." + "codex",
    "." + "claude",
    "AGENTS" + ".md",
    "CLAUDE" + ".md",
}


def is_text_file(path: Path) -> bool:
    if path.name in {".gitignore", ".gitattributes"}:
        return True
    return path.suffix.lower() in TEXT_EXTENSIONS


def check_csv_headers(errors: list[str]) -> None:
    expected_headers = {
        "data/synthetic_timeseries.csv": [
            "time_s",
            "reference",
            "response",
            "disturbance",
            "baseline",
            "method_a",
            "method_b",
        ],
        "data/synthetic_frequency_response.csv": [
            "frequency_hz",
            "magnitude_db",
            "phase_deg",
        ],
    }
    for rel, headers in expected_headers.items():
        path = ROOT / rel
        if not path.exists():
            continue
        with path.open("r", encoding="utf-8", newline="") as handle:
            reader = csv.reader(handle)
            actual = next(reader, [])
        if actual != headers:
            errors.append(f"{rel}: unexpected CSV headers: {actual}")


def main() -> int:
    errors: list[str] = []

    for rel in EXPECTED_FILES:
        path = ROOT / rel
        if not path.exists():
            errors.append(f"missing expected file: {rel}")
        elif path.stat().st_size == 0:
            errors.append(f"empty expected file: {rel}")

    for rel in EXPECTED_OUTPUTS:
        path = ROOT / rel
        if not path.exists():
            errors.append(f"missing generated output: {rel}")
        elif path.stat().st_size < 100:
            errors.append(f"generated output looks empty: {rel}")

    for path in ROOT.rglob("*"):
        if ".git" in path.parts:
            continue
        if path.name in FORBIDDEN_PUBLIC_NAMES and path.name not in {".gitignore"}:
            errors.append(f"forbidden public workspace file: {path.relative_to(ROOT)}")
        if path.is_file() and is_text_file(path):
            text = path.read_text(encoding="utf-8", errors="ignore")
            rel = path.relative_to(ROOT)
            for label, pattern in SENSITIVE_PATTERNS.items():
                for match in pattern.finditer(text):
                    errors.append(f"{rel}: possible {label}: {match.group(0)}")

    check_csv_headers(errors)

    data_files = sorted(p.name for p in (ROOT / "data").glob("*") if p.is_file())
    if data_files != ["synthetic_frequency_response.csv", "synthetic_timeseries.csv"]:
        errors.append(f"data/ should contain only synthetic CSV files, found: {data_files}")

    if errors:
        print("Validation failed:")
        for error in errors:
            print(f"- {error}")
        return 1

    print("Public asset validation passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
