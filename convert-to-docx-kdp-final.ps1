# Script to combine markdown files and convert to DOCX for KDP with proper encoding
# Fixes encoding issues and creates proper table of contents

$bookDir = "book1"
$tempDir = "book1-kdp-temp"
$outputMd = "book1-combined-kdp-final.md"
$outputDocx = "Fracture-Protocol-Path-of-Unintended-Consequence-KDP-FINAL.docx"

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
        $content = Get-Content $filePath -Raw -Encoding UTF8
        
        # Fix System messages: Remove code block markers
        $pattern = '(?s)```\s*\r?\n(.*?)\r?\n```'
        while ($content -match $pattern) {
            $message = $matches[1].Trim()
            $replacement = "`n`n[SYSTEM]`n$message`n[/SYSTEM]`n`n"
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

# Convert to DOCX with proper encoding handling
Write-Host "`nConverting to DOCX for KDP..."
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Pandoc command with UTF-8 and proper settings
# Note: --toc creates a table of contents, but you may need to update it in Word
pandoc $outputMd -o $outputDocx --from=markdown+smart --to=docx --toc --toc-depth=2 --standalone --wrap=none --preserve-tabs

if (Test-Path $outputDocx) {
    Write-Host "DOCX file created: $outputDocx"
    Write-Host ""
    Write-Host "NEXT STEPS:"
    Write-Host "1. Open the DOCX file in Microsoft Word"
    Write-Host "2. Fix System messages (see KDP_FORMATTING_GUIDE.md)"
    Write-Host "3. Update Table of Contents:"
    Write-Host "   - Right-click the TOC → Update Field → Update entire table"
    Write-Host "   - Or delete TOC and insert new: References → Table of Contents"
    Write-Host "4. Check for encoding issues - em dashes, quotes, etc."
} else {
    Write-Warning "DOCX file was not created. Check for errors above."
}

Write-Host ""
Write-Host "Done!"


