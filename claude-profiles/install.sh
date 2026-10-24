#!/usr/bin/env bash
# Install claude-as onto your PATH and build all profile runtime dirs.
set -euo pipefail

HERE="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
BIN_DIR="${BIN_DIR:-$HOME/.local/bin}"

chmod +x "$HERE/bin/claude-as"
mkdir -p "$BIN_DIR"
ln -sfn "$HERE/bin/claude-as" "$BIN_DIR/claude-as"
"$HERE/bin/claude-as" --sync --all

echo "installed: $BIN_DIR/claude-as"
echo "profiles:  $("$HERE/bin/claude-as" --list | tr '\n' ' ')"

case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *) echo "note: $BIN_DIR is not on your PATH; add it to your shell profile." ;;
esac
