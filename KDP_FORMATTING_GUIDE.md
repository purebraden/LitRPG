# KDP Formatting Guide - System Messages

## Problem Fixed

The original DOCX file had System messages in markdown code blocks (```) which don't convert properly for KDP. These have been fixed.

## What Was Changed

1. **Removed code block markers**: All triple backticks (```) around System messages have been removed
2. **Added markers**: System messages now have `[SYSTEM]` and `[/SYSTEM]` markers for easy identification
3. **Created KDP-ready DOCX**: New file: `Fracture-Protocol-Path-of-Unintended-Consequence-KDP.docx`

## Next Steps in Word

### 1. Open the KDP DOCX File
Open `Fracture-Protocol-Path-of-Unintended-Consequence-KDP.docx` in Microsoft Word

### 2. Format System Messages

**Option A: Centered, All Caps (Recommended)**
1. Use Find & Replace (Ctrl+H)
2. Find: `[SYSTEM]`
3. Replace with: (leave empty)
4. Find: `[/SYSTEM]`
5. Replace with: (leave empty)
6. For each System message:
   - Select the System message text (the all-caps text between the markers)
   - Format as:
     - **Alignment**: Center
     - **Font**: Bold
     - **Case**: UPPERCASE (if not already)
     - **Spacing**: Add space before/after paragraph

**Option B: Text Box/Border (More Visual)**
1. Remove the `[SYSTEM]` and `[/SYSTEM]` markers
2. For each System message:
   - Select the System message text
   - Insert → Text Box → Simple Text Box
   - Format the text box:
     - Center alignment
     - Border (optional)
     - Background color (light gray, optional)
   - Position centered on page

**Option C: Simple Formatting**
1. Remove markers
2. Select each System message
3. Format as: **Bold, Centered, All Caps**
4. Add paragraph spacing before/after

### 3. Final Checks

- [ ] All `[SYSTEM]` and `[/SYSTEM]` markers removed
- [ ] All System messages properly formatted
- [ ] No remaining backticks (```) in the document
- [ ] No markdown syntax remaining
- [ ] Chapter breaks are page breaks (Insert → Page Break)
- [ ] Table of contents is correct
- [ ] Font is consistent (12pt recommended)
- [ ] Line spacing is readable (1.5 recommended)
- [ ] No headers/footers (KDP adds these automatically)
- [ ] No page numbers (KDP handles this)

### 4. Save and Upload

Once formatting is complete:
1. Save the file
2. Upload to KDP (see `meta/publishing.md` for step-by-step guide)

## Example System Message Format

**Before (in markdown):**
```
DEBT COLLECTION: INITIATED
SCOPE: COHORT
METHOD: CORRECTIVE PRESSURE (NON-LETHAL)
```

**After (in Word):**
- Centered
- **BOLD**
- ALL CAPS
- With spacing before/after

## Troubleshooting

**If you see backticks in the DOCX:**
- Use Find & Replace to remove them
- Search for: `` ` `` (single backtick)
- Replace with: (empty)

**If System messages look wrong:**
- Check that you removed the `[SYSTEM]` markers
- Ensure text is properly selected before formatting
- Try Option A first (simplest)

**If formatting is inconsistent:**
- Use Word's Format Painter to copy formatting from one System message to others
- Or create a Style for System messages and apply it consistently

