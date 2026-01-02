# Script to combine markdown files and convert to DOCX
# Run this from the repository root directory

$bookDir = "book1"
$outputMd = "book1-combined.md"
$outputDocx = "Fracture-Protocol-Path-of-Unintended-Consequence.docx"

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

# Try to convert to DOCX using pandoc
Write-Host "`nAttempting to convert to DOCX..."
$pandocInstalled = $false
try {
    $null = Get-Command pandoc -ErrorAction Stop
    $pandocInstalled = $true
} catch {
    $pandocInstalled = $false
}

if ($pandocInstalled) {
    Write-Host "Pandoc found! Converting to DOCX..."
    pandoc $outputMd -o $outputDocx
    if ($LASTEXITCODE -eq 0) {
        Write-Host "DOCX file created: $outputDocx"
    } else {
        Write-Warning "Pandoc conversion failed."
    }
} else {
    Write-Host ""
    Write-Host "Pandoc not found. CONVERSION OPTIONS:"
    Write-Host "1. Install Pandoc:"
    Write-Host "   Download from: https://pandoc.org/installing.html"
    Write-Host "   Or use: winget install --id=JohnMacFarlane.Pandoc -e"
    Write-Host "   Then run: pandoc $outputMd -o $outputDocx"
    Write-Host ""
    Write-Host "2. Use online converter:"
    Write-Host "   Upload $outputMd to: https://cloudconvert.com/md-to-docx"
    Write-Host ""
    Write-Host "3. Use Word:"
    Write-Host "   Open $outputMd in Microsoft Word"
    Write-Host "   Word will convert it automatically"
    Write-Host "   Save as .docx"
}

Write-Host ""
Write-Host "Done! Combined markdown file: $outputMd"
