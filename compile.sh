#!/usr/bin/env bash
# Canonical compilation script for the PoliTo thesis.

set -euo pipefail

main_auxiliary_files=(
    main.aux
    main.log
    main.toc
    main.lof
    main.lot
    main.out
    main.bbl
    main.blg
    main.run.xml
    main.bcf
    main.synctex.gz
    main.nlo
    main.nls
    main.glo
    main.gls
    main.glg
    main.glsdefs
    main.alg
    main.acn
    main.acr
    main.ist
    main.nav
    main.snm
    main.vrb
    main.fls
    main.fdb_latexmk
    main.idx
    main.ind
    main.ilg
    main.xdy
)

clean_auxiliary_files() {
    rm -f "${main_auxiliary_files[@]}"
}

clear_generated_files() {
    echo "Removing all generated LaTeX files..."
    clean_auxiliary_files
    rm -f main.pdf

    echo "Cleanup complete. Preserved: main.tex"
}

case "${1:-}" in
    clear)
        clear_generated_files
        exit 0
        ;;
    "")
        ;;
    *)
        echo "Usage: $0 [clear]" >&2
        exit 1
        ;;
esac

required_tools=(pdflatex biber makeglossaries)

for tool in "${required_tools[@]}"; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "Missing required tool: $tool" >&2
        exit 1
    fi
done

echo "Cleaning stale auxiliary files..."
clean_auxiliary_files

echo "Building PDF (Phase 1)..."
pdflatex -interaction=nonstopmode -halt-on-error main.tex

echo "Running Biber (Citations)..."
biber main

echo "Running Makeglossaries..."
makeglossaries main

echo "Building PDF (Phase 2)..."
pdflatex -interaction=nonstopmode -halt-on-error main.tex

echo "Building PDF (Phase 3 - Final)..."
pdflatex -interaction=nonstopmode -halt-on-error main.tex

echo "Compilation successful. Removing auxiliary files..."
clean_auxiliary_files

echo "Compilation complete."
echo "Preserved files: main.tex and main.pdf"
