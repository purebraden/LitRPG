# Script to combine FIXED markdown files and convert to DOCX for KDP
# Uses the fixed files from book1-kdp-temp directory

$bookDir = "book1-kdp-temp"
$outputMd = "book1-combined-kdp.md"
$outputDocx = "Fracture-Protocol-Path-of-Unintended-Consequence-KDP.docx"

# Check if fixed files exist
if (-not (Test-Path $bookDir)) {
    Write-Host "ERROR: Fixed files directory not found. Run fix-markdown-for-kdp.ps1 first."
    exit 1
}

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

# Create combined markdown file
$combinedContent = ""

foreach ($file in $files) {
    $filePath = Join-Path $bookDir $file
    
    if (Test-Path $filePath) {
        Write-Host "Adding: $file"
        $content = Get-Content $filePath -Raw
        
        # Add page break before each new section (except first)
        if ($combinedContent -ne "") {
            $combinedContent += "`n`n---`n`n"
        }
        
        $combinedContent += $content
    } else {
        Write-Warning "File not found: $filePath"
    }
}

# Write combined markdown file
$combinedContent | Out-File -FilePath $outputMd -Encoding UTF8
Write-Host "`nCombined markdown file created: $outputMd"

# Convert to DOCX
Write-Host "`nConverting to DOCX for KDP..."
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Pandoc command with KDP-friendly settings
pandoc $outputMd -o $outputDocx --toc --toc-depth=2 --standalone --wrap=none

if (Test-Path $outputDocx) {
    Write-Host "DOCX file created: $outputDocx"
    Write-Host ""
    Write-Host "IMPORTANT NEXT STEPS:"
    Write-Host "1. Open the DOCX file in Microsoft Word"
    Write-Host "2. Use Find and Replace to find: [SYSTEM]"
    Write-Host "3. Replace with: (leave empty)"
    Write-Host "4. Find: [/SYSTEM]"
    Write-Host "5. Replace with: (leave empty)"
    Write-Host "6. For each System message:"
    Write-Host "   - Select the System message text"
    Write-Host "   - Format as: Centered, All Caps, Bold"
    Write-Host "   - Or use a text box/border for visual distinction"
    Write-Host "7. Check for any remaining markdown syntax"
    Write-Host "8. Review formatting throughout"
} else {
    Write-Warning "DOCX file was not created. Check for errors above."
}

Write-Host ""
Write-Host "Done!"
