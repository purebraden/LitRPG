# Fixing Encoding Issues in DOCX File

## Problem

The DOCX file has encoding issues showing characters like:
- `â€"` instead of em dashes (—)
- `â€"` instead of en dashes (–)
- `â€™` instead of apostrophes (')
- Other garbled special characters

## Solution

The new conversion script (`convert-to-docx-kdp-final.ps1`) handles UTF-8 encoding properly. Run it to generate a new DOCX file.

## If Issues Persist in Word

### Option 1: Find and Replace in Word

1. Open the DOCX file in Microsoft Word
2. Use Find & Replace (Ctrl+H)
3. Replace common encoding errors:

**Common Replacements:**
- Find: `â€"` → Replace: `—` (em dash)
- Find: `â€"` → Replace: `–` (en dash)  
- Find: `â€™` → Replace: `'` (apostrophe)
- Find: `â€œ` → Replace: `"` (left quote)
- Find: `â€` → Replace: `"` (right quote)
- Find: `â€¦` → Replace: `…` (ellipsis)

### Option 2: Fix in Source Markdown (Recommended)

If you want to fix it at the source:
1. Open markdown files in a UTF-8 editor (VS Code, Notepad++)
2. Check encoding is UTF-8
3. Re-run conversion script

### Option 3: Use Word's Encoding Detection

1. Open DOCX in Word
2. File → Options → Advanced
3. Under "General", check "Confirm file format conversion on open"
4. Reopen the file and select "Encoded Text" if prompted
5. Choose UTF-8 encoding

## Table of Contents Fix

The TOC might not generate correctly from Pandoc. Fix it in Word:

### Method 1: Update Existing TOC
1. Right-click on the Table of Contents
2. Select "Update Field"
3. Choose "Update entire table"

### Method 2: Create New TOC
1. Delete the existing TOC (if present)
2. Place cursor where TOC should go (after title page, before prologue)
3. References → Table of Contents
4. Choose "Automatic Table 1" or "Automatic Table 2"
5. Word will auto-generate based on heading styles

### Method 3: Manual TOC (If automatic doesn't work)
1. Ensure all chapters use Heading 1 or Heading 2 style
2. Insert → Table of Contents → Manual Table
3. Or create manually with proper page numbers

## Quick Check List

- [ ] Run `convert-to-docx-kdp-final.ps1` to generate new DOCX
- [ ] Open DOCX in Word
- [ ] Check for encoding issues (search for `â€`)
- [ ] Fix System messages (remove [SYSTEM] markers, format)
- [ ] Update/Create Table of Contents
- [ ] Verify all special characters display correctly
- [ ] Check chapter breaks are page breaks
- [ ] Final review before uploading to KDP

