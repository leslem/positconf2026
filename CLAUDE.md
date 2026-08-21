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

## Files

- `outline.qmd` → renders to `outline.html`. The initial planning document: the talk
  outline, the "5 lines" narrative arc (Situation / Desire / Conflict / Change / Result),
  and the rhetorical plan (logos/ethos/pathos). This is frozen — active work has moved to
  the slides, and the outline is not kept in sync with the real talk. Read it for original
  intent, but don't update it to match the deck.
- `configurable-harmonization-LLMs.qmd` → renders to `configurable-harmonization-LLMs.html`.
  The reveal.js slide deck. Currently a scaffold: one slide per section with the talk content
  living in `::: {.notes}` speaker-note blocks. Fleshing these out into real slide bodies is
  the main ongoing work.
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

- Slide content is drafted inside `::: {.notes}` blocks keyed to each `##` section heading.
  When converting notes to slide bodies, preserve the section headings — they define the deck's structure.
- The slide deck is the single source of truth for the talk. `outline.qmd` is a frozen
  planning artifact; don't sync changes back into it.
