# Markdown to DOCX Conversion

## Files Created

- **book1-combined.md**: Combined markdown file with all chapters in order
- **Fracture-Protocol-Path-of-Unintended-Consequence.docx**: Final DOCX file ready for KDP upload

## How It Was Created

1. Combined all markdown files from `book1/` directory in order:
   - Prologue
   - Chapter 01-21
   - Epilogue

2. Converted to DOCX using Pandoc with table of contents

## To Re-create the DOCX

Run the conversion script:
```powershell
.\convert-to-docx.ps1
```

Or manually with Pandoc:
```powershell
pandoc book1-combined.md -o "Fracture-Protocol-Path-of-Unintended-Consequence.docx" --toc
```

## Next Steps for KDP

1. **Open the DOCX in Word** and review:
   - Check formatting looks good
   - Verify chapter breaks
   - Ensure page breaks are correct
   - Review table of contents

2. **Add front matter** (if not already in markdown):
   - Title page
   - Copyright page
   - Dedication (optional)
   - Table of contents (should be auto-generated)

3. **Final formatting**:
   - Set proper page breaks between chapters (Insert → Page Break)
   - Check font consistency (recommend 12pt for body)
   - Verify no headers/footers (KDP adds these automatically)
   - Remove any manual page numbers (KDP handles this)

4. **Save and upload** to KDP

## Note

The DOCX file is generated and can be recreated from the markdown files, so it doesn't need to be committed to git unless you want to track it.

