# Plotting Guidelines

These guidelines keep MATLAB figures readable after export and resizing.

## Figure Style

- Use a white background.
- Use colorblind-friendly colors instead of rainbow-like palettes.
- Keep line widths thick enough for single-column paper figures.
- Prefer clear axis labels over long plot titles.
- Use legends only when they help identify curves; avoid covering data.
- Keep grid lines light.
- Use consistent font family and font size across figures.

## Export Rules

- Export PNG for README previews.
- Export PDF for Word, reports, and vector-like sharing when supported.
- Export SVG for web or further editing when supported.
- Keep a stable figure size for repeatable output.

## Synthetic Data Rules

- Do not reuse real experimental curves.
- Do not encode real equipment parameters.
- Use generic variable names such as `response`, `reference`, `frequency_hz`, and `magnitude_db`.
- Do not describe synthetic curves as validation evidence.

## Caption Style

Good:

```text
Synthetic time-series example using publication-style MATLAB formatting.
```

Avoid:

```text
Experimental result showing real controller performance.
```
