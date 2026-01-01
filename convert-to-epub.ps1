# Script to convert markdown files directly to EPUB for KDP
# EPUB is a standard eBook format that KDP accepts natively
# No Word subscription needed!

$bookDir = "book1"
$tempDir = "book1-epub-temp"
$outputMd = "book1-combined-epub.md"
$outputEpub = "Fracture-Protocol-Path-of-Unintended-Consequence.epub"

# Clean up temp directory
if (Test-Path $tempDir) {
    Remove-Item $tempDir -Recurse -Force
}
New-Item -ItemType Directory -Path $tempDir | Out-Null

# Define the order of files
$files = @(
    "prologue.md",
    "chapter01.md",
    "chapter02.md",
    "chapter03.md",
    "chapter04.md",
    "chapter05.md",
    "chapter06.md",
    "chapter07.md",
    "chapter08.md",
    "chapter09.md",
    "chapter10.md",
    "chapter11.md",
    "chapter12.md",
    "chapter13.md",
    "chapter14.md",
    "chapter15.md",
    "chapter16.md",
    "chapter17.md",
    "chapter18.md",
    "chapter19.md",
    "chapter20.md",
    "chapter21.md",
    "epilogue.md"
)

# Process each file to fix System messages and ensure UTF-8 encoding
foreach ($file in $files) {
    $filePath = Join-Path $bookDir $file
    
    if (Test-Path $filePath) {
        Write-Host "Processing: $file"
        
        # Read with UTF-8 encoding
        $content = [System.IO.File]::ReadAllText($filePath, [System.Text.UTF8Encoding]::new($false))
        
        # Fix System messages: Remove code block markers
        $pattern = '(?s)```\s*\r?\n(.*?)\r?\n```'
        while ($content -match $pattern) {
            $message = $matches[1].Trim()
            # For EPUB, use HTML-style formatting that will look good
            $replacement = "`n`n<div class='system-message'>`n$message`n</div>`n`n"
            $content = $content -replace [regex]::Escape($matches[0]), $replacement
        }
        
        # Write to temp directory with UTF-8 encoding
        $outputPath = Join-Path $tempDir $file
        [System.IO.File]::WriteAllText($outputPath, $content, [System.Text.UTF8Encoding]::new($false))
    } else {
        Write-Warning "File not found: $filePath"
    }
}

# Combine files
Write-Host "`nCombining files..."
$combinedContent = ""

foreach ($file in $files) {
    $filePath = Join-Path $tempDir $file
    
    if (Test-Path $filePath) {
        Write-Host "Adding: $file"
        $content = [System.IO.File]::ReadAllText($filePath, [System.Text.UTF8Encoding]::new($false))
        
        # Add page break before each new section (except first)
        if ($combinedContent -ne "") {
            $combinedContent += "`n`n---`n`n"
        }
        
        $combinedContent += $content
    }
}

# Write combined file with UTF-8 encoding
[System.IO.File]::WriteAllText($outputMd, $combinedContent, [System.Text.UTF8Encoding]::new($false))
Write-Host "`nCombined markdown file created: $outputMd"

# Convert to EPUB
Write-Host "`nConverting to EPUB for KDP..."
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Pandoc command for EPUB with proper metadata
$title = "Fracture Protocol: Path of Unintended Consequence"
$author = "Jessica Braden"

pandoc $outputMd -o $outputEpub `
    --from=markdown+smart `
    --to=epub3 `
    --epub-chapter-level=2 `
    --toc `
    --toc-depth=2 `
    --standalone `
    --metadata title="$title" `
    --metadata author="$author" `
    --css=epub-style.css

if (Test-Path $outputEpub) {
    Write-Host "SUCCESS: EPUB file created: $outputEpub"
    Write-Host ""
    Write-Host "NEXT STEPS:"
    Write-Host "1. Upload $outputEpub directly to KDP"
    Write-Host "2. Use Kindle Previewer to check formatting:"
    Write-Host "   - Download from: https://kdp.amazon.com/en_US/help/topic/G202131170"
    Write-Host "   - Open the EPUB file in Kindle Previewer"
    Write-Host "   - Check System messages look good"
    Write-Host "   - Verify table of contents works"
    Write-Host ""
    Write-Host "Note: EPUB format often converts better than DOCX for eBooks!"
} else {
    Write-Warning "EPUB file was not created. Check for errors above."
}

Write-Host ""
Write-Host "Done!"

