# Fracture Protocol: Path of Unintended Consequence

A LitRPG novel featuring Rowan Mercer, a software engineer with SRE/reliability background, who finds herself in a world governed by a System that optimizes outcomes over lives.

## Project Structure

```
LitRPG/
├── book1/                    # Book 1 source files (markdown chapters)
├── series-bible/             # Series world-building and character docs
├── meta/                     # Publishing metadata, outlines, blurbs
├── scripts/                  # Conversion and build scripts
├── output/                   # Generated files (EPUB, DOCX, combined markdown)
├── docs/                     # Documentation, reviews, progress notes
├── temp/                     # Temporary build files
└── images/                   # Book covers and images
```

## Quick Start

### Generate EPUB for KDP Publishing

```powershell
.\scripts\convert-to-epub.ps1
```

This creates `output/Fracture-Protocol-Path-of-Unintended-Consequence.epub` ready for KDP upload.

### Generate DOCX (if needed)

```powershell
.\scripts\convert-to-docx-kdp-final.ps1
```

## Publishing

See `meta/publishing.md` for complete step-by-step KDP publishing guide.

**Recommended format**: EPUB (no Word subscription needed!)

## Key Files

- **`book1/`** - All chapter markdown files
- **`meta/publishing.md`** - Complete KDP publishing guide
- **`meta/titles-and-blurbs.md`** - Marketing copy and titles
- **`series-bible/`** - World-building documentation
- **`docs/`** - Reviews, progress notes, formatting guides

## Scripts

All conversion scripts are in `scripts/`:
- `convert-to-epub.ps1` - Generate EPUB (recommended)
- `convert-to-docx-kdp-final.ps1` - Generate DOCX with encoding fixes
- `fix-markdown-for-kdp.ps1` - Fix System messages in markdown

## Documentation

See `docs/` folder for:
- Formatting guides
- Publishing guides
- Review notes
- Progress tracking

## License

See LICENSE file for details.
