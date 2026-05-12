#!/bin/bash
# Compilation script for PoliTo Thesis

echo "Building PDF (Phase 1)..."
pdflatex -interaction=nonstopmode main.tex || true

echo "Running Biber (Citations)..."
biber main || true

echo "Running Makeglossaries..."
makeglossaries main || true

echo "Building PDF (Phase 2)..."
pdflatex -interaction=nonstopmode main.tex || true

echo "Building PDF (Phase 3 - Final)..."
pdflatex -interaction=nonstopmode main.tex || true

echo "Cleaning auxiliary files..."
rm -f *.aux *.log *.toc *.lof *.lot *.out *.bbl *.blg *.run.xml *.bcf *.synctex.gz *.nlo *.nls *.glo *.gls *.glg *.alg *.acn *.acr *.ist

echo "Compilation complete. Output: main.pdf"
