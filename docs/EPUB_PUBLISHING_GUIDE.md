# Publishing with EPUB Format

## Why EPUB?

According to [KDP's supported formats](https://kdp.amazon.com/en_US/help/topic/G200634390), EPUB is a **recommended format** that KDP accepts natively. Benefits:

✅ **No Word subscription needed** - EPUB is a standard eBook format  
✅ **Better conversion** - EPUB often converts better than DOCX for eBooks  
✅ **Native format** - KDP accepts EPUB directly  
✅ **Editable** - Can edit EPUB files with free tools if needed  
✅ **Standard** - EPUB is the industry standard for eBooks  

## File Created

The script creates: **`Fracture-Protocol-Path-of-Unintended-Consequence.epub`**

This file can be uploaded directly to KDP!

## Upload to KDP

1. Go to your [KDP Bookshelf](https://kdp.amazon.com/bookshelf)
2. Create a new book or edit existing book
3. In the "Upload Book Content" section
4. Upload the `.epub` file
5. KDP will convert it automatically

## Preview Your Book

**Before publishing, preview your book:**

1. Download **Kindle Previewer** (free):
   - [KDP Help: Kindle Previewer](https://kdp.amazon.com/en_US/help/topic/G202131170)
   - Or search "Kindle Previewer" on Amazon

2. Open your EPUB file in Kindle Previewer
3. Check:
   - ✅ System messages display correctly
   - ✅ Table of contents works
   - ✅ Chapter breaks look good
   - ✅ Special characters display correctly (em dashes, quotes, etc.)
   - ✅ Formatting looks good on different device sizes

## If You Need to Edit the EPUB

### Option 1: Calibre (Free, Recommended)
1. Download [Calibre](https://calibre-ebook.com/) (free, open source)
2. Add your EPUB file to Calibre library
3. Click "Edit book" 
4. Edit as needed
5. Save

### Option 2: Sigil (Free EPUB Editor)
1. Download [Sigil](https://sigil-ebook.com/) (free EPUB editor)
2. Open your EPUB file
3. Edit directly
4. Save

### Option 3: Convert Back to Markdown
If you need major edits:
1. Use Calibre to convert EPUB back to markdown
2. Edit the markdown files
3. Re-run `convert-to-epub.ps1`

## Formatting System Messages in EPUB

The EPUB includes CSS styling for System messages. They will appear:
- Centered
- Bold/Monospace font
- With background/border to distinguish from regular text

If you want to change the styling:
1. Edit `epub-style.css` 
2. Re-run the conversion script
3. The CSS will be included in the EPUB

## KDP Requirements

Make sure your EPUB file:
- ✅ Validates correctly (Kindle Previewer will check this)
- ✅ Has a table of contents (included automatically)
- ✅ System messages are readable and formatted
- ✅ All text displays correctly
- ✅ No encoding issues

## Next Steps

1. **Run the conversion script** to create EPUB
2. **Preview in Kindle Previewer** to check formatting
3. **Upload to KDP** - use the EPUB file directly
4. **Review in KDP preview** before publishing

That's it! No Word subscription needed! 🎉

