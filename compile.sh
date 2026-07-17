#!/usr/bin/env bash
# Canonical compilation script for the PoliTo thesis.

set -euo pipefail

required_tools=(pdflatex biber makeglossaries)
for tool in "${required_tools[@]}"; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "Missing required tool: $tool" >&2
        exit 1
    fi
done

auxiliary_files=(
    *.aux *.log *.toc *.lof *.lot *.out *.bbl *.blg *.run.xml *.bcf
    *.synctex.gz *.nlo *.nls *.glo *.gls *.glg *.alg *.acn *.acr *.ist
    *.nav *.snm *.vrb
)

clean_auxiliary_files() {
    rm -f "${auxiliary_files[@]}"
}

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

echo "Cleaning auxiliary files..."
clean_auxiliary_files

echo "Compilation complete. Output: main.pdf"
