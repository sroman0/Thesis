#!/usr/bin/env bash
# Compile the standalone thesis summary.

set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$script_dir"

auxiliary_files=(
    main.aux
    main.log
    main.out
    main.synctex.gz
    main.fls
    main.fdb_latexmk
    missfont.log
)

clean_auxiliary_files() {
    rm -f "${auxiliary_files[@]}"
}

case "${1:-}" in
    clear)
        echo "Removing generated summary files..."
        clean_auxiliary_files
        rm -f main.pdf
        echo "Cleanup complete."
        exit 0
        ;;
    "")
        ;;
    *)
        echo "Usage: $0 [clear]" >&2
        exit 1
        ;;
esac

if ! command -v pdflatex >/dev/null 2>&1; then
    echo "Missing required tool: pdflatex" >&2
    exit 1
fi

export TEXMFVAR="${TEXMFVAR:-/tmp/texmfvar-${USER:-user}}"
mkdir -p "$TEXMFVAR"

echo "Cleaning stale auxiliary files..."
clean_auxiliary_files

echo "Building summary PDF (pass 1/2)..."
pdflatex -interaction=nonstopmode -halt-on-error main.tex

echo "Building summary PDF (pass 2/2)..."
pdflatex -interaction=nonstopmode -halt-on-error main.tex

echo "Removing auxiliary files..."
clean_auxiliary_files

echo "Compilation complete: $script_dir/main.pdf"
