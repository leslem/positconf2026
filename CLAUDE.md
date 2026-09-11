# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

This repo is the source for a posit::conf 2026 talk by Leslie Emery (Bristol-Myers Squibb):
"Configurable clinical data harmonization with help from LLMs." It is a Quarto project, not
a software package — the deliverables are a rendered outline and a slide deck. The talk's
thesis: replace bespoke per-study R harmonization code with an LLM-assisted workflow built
around a **data model** (output format, YAML), **harmonization configs** (per-study input
descriptions, YAML), and **generalized config-driven code**, all version-controlled with
space for human review.

## Division of labor

**Leslie writes all slide content.** The words, narrative, code examples, and speaker
notes are hers. Claude's role on this repo is strictly **HTML formatting and slide
styling/layout** — reveal.js structure, CSS/inline styles, fragment builds, positioning,
the SCSS theme, and the `_*.qmd` partials. Do not write, rewrite, or reword the substance
of slide copy or speaker notes unless explicitly asked; when a task is about wording, limit
the change to exactly what's requested and leave the rest of the prose alone.

## Files

- `outline.qmd` → renders to `outline.html`. The initial planning document: the talk
  outline, the "5 lines" narrative arc (Situation / Desire / Conflict / Change / Result),
  and the rhetorical plan (logos/ethos/pathos). This is frozen — active work has moved to
  the slides, and the outline is not kept in sync with the real talk. Read it for original
  intent, but don't update it to match the deck.
- `configurable-harmonization-LLMs.qmd` → renders to `configurable-harmonization-LLMs.html`.
  The reveal.js slide deck and single source of truth for the talk. Slide bodies are built
  out, with much of the visual content factored into `_*.qmd` partials (diagrams, code
  blocks, YAML examples) pulled in via `{{< include >}}`. The content is Leslie's; the
  ongoing work here is formatting, styling, and layout.
- `_*.qmd` partials and `bms-reveal.scss` hold most of the layout/styling work: HTML
  diagrams and overlays, code/YAML blocks, and the theme. This is where Claude's edits
  usually land.
- Rendered `.html` files and their `*_files/` asset directories are committed to git
  intentionally — keep them in sync with the `.qmd` sources.
- `bms-resources/` (gitignored) holds BMS branding/style references: PowerPoint template,
  publication and slide style guides. Consult these for visual/brand conventions; do not commit them.

## Building

Requires Quarto (developed against 1.6.42).

```sh
quarto render outline.qmd                       # → outline.html
quarto render configurable-harmonization-LLMs.qmd   # → slides
```

After editing a `.qmd`, re-render it so the committed `.html` stays current.

`preview.sh` is the user's own live-preview workflow — they run it in a terminal
while editing. It wraps `quarto preview` but also polls the files Quarto won't
watch on its own (`bms-reveal.scss` and the `_*.qmd` partials) and `touch`es the
deck when any change, forcing a rebuild + browser reload. It is meant to be run
by the user, not by Claude. Do NOT suggest or offer to run `quarto preview` (or
`preview.sh`) — assume the user already has it running.

## Conventions

- Speaker notes live in `::: {.notes}` blocks keyed to each `##` section heading. Preserve
  the section headings — they define the deck's structure — and don't rewrite note or slide
  prose except when explicitly asked (see Division of labor).
- Reusable/visual slide content is factored into `_*.qmd` partials included with
  `{{< include _name.qmd >}}`. Each partial opens with a short comment header describing its
  purpose; keep raw HTML inside a ```{=html} fence.
- The slide deck is the single source of truth for the talk. `outline.qmd` is a frozen
  planning artifact; don't sync changes back into it.
