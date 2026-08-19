#!/usr/bin/env bash
# Live-preview the slide deck, rebuilding when the .qmd *or* the theme files change.
#
# `quarto preview` only watches the input .qmd (not the theme SCSS or the
# include-in-header partial), so we poll those extra files and `touch` the .qmd
# when any of them changes -- that triggers Quarto's own rebuild + browser reload.
set -euo pipefail

QMD="configurable-harmonization-LLMs.qmd"
WATCH=(bms-reveal.scss title-logo.html)   # extra files quarto won't watch on its own

fingerprint() { stat -f '%m %z %N' "${WATCH[@]}" 2>/dev/null | cksum; }

watch_extra_files() {
  local last cur
  last=$(fingerprint)
  while sleep 1; do
    cur=$(fingerprint)
    if [ "$cur" != "$last" ]; then
      echo "[preview.sh] theme change detected -> rebuilding"
      touch "$QMD"
      last=$cur
    fi
  done
}

watch_extra_files &
WATCHER=$!
trap 'kill "$WATCHER" 2>/dev/null' EXIT INT TERM

quarto preview "$QMD" "$@"
