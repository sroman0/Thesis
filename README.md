# Thesis report

LaTeX repository for the thesis:

**Design and Implementation of an eBPF-based Security Monitoring Tool**

## Structure

```text
.
├── main.tex                  # Main LaTeX entrypoint
├── compile.sh                # Build script for the final PDF
├── bibliography.bib          # Bibliography used by main.tex
├── glossaries.tex            # Acronyms and glossary entries
├── common/                   # Packages, front page and thesis metadata
├── content/
│   ├── abstract.tex
│   ├── acknowledgements.tex
│   ├── chapters.tex          # Includes chapter files
│   ├── chapters/             # Thesis chapters
│   ├── appendixA.tex
│   └── appendixB.tex
├── figures/                  # Figures used in the report
├── tables/                   # Table snippets
└── references/               # Local reference theses and supporting PDFs
```

## Build

Compile the report from this directory:

```bash
cd report
./compile.sh
```

The script runs `pdflatex`, `biber`, `makeglossaries` and the final LaTeX
passes, then removes auxiliary files. The generated PDF is:

```text
main.pdf
```

## Requirements

The build expects a working LaTeX environment with:

- `pdflatex`
- `biber`
- `makeglossaries`

On TeX Live based systems, these are usually provided by a full or extended
TeX Live installation.

## Writing workflow

Chapters are stored in:

```text
content/chapters/
```

The chapter inclusion file is:

```text
content/chapters.tex
```

When adding a new chapter:

1. Create a new `.tex` file under `content/chapters/`.
2. Add the corresponding `\input{content/chapters/...}` line in
   `content/chapters.tex`.
3. Compile with `./compile.sh`.

The first chapter currently lives in:

```text
content/chapters/chapter1.tex
```

## Front matter

Thesis metadata is defined in:

```text
common/thesis_info.tex
```

The custom front page is defined in:

```text
common/frontpage.tex
```

The abstract is stored separately in:

```text
content/abstract.tex
```

## Bibliography and glossary

Bibliography entries should be added to:

```text
bibliography.bib
```

Acronyms and glossary entries should be added to:

```text
glossaries.tex
```

The build script already runs `biber` and `makeglossaries`.

## References

The `references/` directory contains local reference material used while
structuring the thesis, including previous theses with related supervision or
technical scope. These files are supporting material and are not automatically
included in the compiled report.

## Notes

- Use `compile.sh` as the canonical build command.
- Keep generated auxiliary files out of version control.
- Add thesis prose in chapter files under `content/chapters/`.
- Use `figures/` and `tables/` for report assets and reusable table snippets.
