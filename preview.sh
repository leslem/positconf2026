#!/usr/bin/env bash
# Live-preview the slide deck, rebuilding when the .qmd *or* its dependencies change.
#
# `quarto preview` only watches the input .qmd -- not the theme SCSS nor the
# `{{< include >}}` partials -- so we poll those extra files and `touch` the .qmd
# when any of them changes, which triggers Quarto's own rebuild + browser reload.
set -euo pipefail

QMD="configurable-harmonization-LLMs.qmd"
# Fixed port so the preview URL is the same every run (override with PORT=... ).
PORT="${PORT:-4321}"
# Extra files quarto won't watch on its own: the theme and all _*.qmd partials
# (the leading underscore marks Quarto include/partial files).
WATCH=(bms-reveal.scss _*.qmd)

# Hash the watched files' mtime/size/name. Must NEVER return non-zero: a watched
# file briefly disappears mid-save (editors save via write-temp-then-rename), and
# under `set -e -o pipefail` a failing pipeline here would kill the watcher.
fingerprint() { { stat -f '%m %z %N' "${WATCH[@]}" 2>/dev/null | cksum; } || true; }

watch_extra_files() {
  local last cur
  last=$(fingerprint)
  while sleep 1; do
    cur=$(fingerprint)
    if [ "$cur" != "$last" ]; then
      # Debounce: wait for the files to stop changing before triggering a
      # rebuild. Touching mid-save (or on every write of a burst) makes
      # Quarto start overlapping renders, and concurrent knitr renders race
      # on the working directory -- one then fails to find the .qmd by its
      # relative path ("cannot open file ...: No such file or directory").
      # Settling first collapses each burst into a single, clean rebuild.
      while last=$cur; sleep 1; cur=$(fingerprint); [ "$cur" != "$last" ]; do :; done
      echo "[preview.sh] theme change detected -> rebuilding"
      touch "$QMD"
      last=$cur
    fi
  done
}

# A crashed/leftover preview still holding the fixed port would make quarto fail
# to bind. Free it first (only ever ours, since the port is dedicated here).
if pids=$(lsof -ti "tcp:$PORT" 2>/dev/null) && [ -n "$pids" ]; then
  echo "[preview.sh] freeing port $PORT (killing: $pids)"
  kill $pids 2>/dev/null || true
  sleep 1
fi

watch_extra_files &
WATCHER=$!
trap 'kill "$WATCHER" 2>/dev/null' EXIT INT TERM

quarto preview "$QMD" --port "$PORT" "$@"
