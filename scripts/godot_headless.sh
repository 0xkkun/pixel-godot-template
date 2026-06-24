#!/usr/bin/env bash
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$ROOT"

GODOT="${GODOT_BIN:-godot}"
PYTHON="${PYTHON_BIN:-python3}"
LOG_DIR="${GODOT_HEADLESS_LOG_DIR:-test-results/godot-headless}"
mkdir -p "$LOG_DIR"

if ! command -v "$GODOT" >/dev/null 2>&1; then
  echo "[godot_headless] FAIL: Godot executable not found: $GODOT" >&2
  echo "[godot_headless] Set GODOT_BIN=/absolute/path/to/Godot if needed." >&2
  exit 1
fi

stamp="$(date +%Y%m%dT%H%M%S)"
log_file="$LOG_DIR/godot-${stamp}-$$.log"

set +e
"$GODOT" --headless --path "$ROOT" --log-file "$log_file" "$@" 2>&1 | tee -a "$log_file"
status="${PIPESTATUS[0]}"
set -e

"$PYTHON" scripts/verify_godot_output.py "$log_file"

if [ "$status" -ne 0 ]; then
  echo "[godot_headless] FAIL: Godot exited with status $status" >&2
  echo "[godot_headless] Log: $log_file" >&2
  exit "$status"
fi

echo "[godot_headless] OK: $log_file"
