# Script to combine markdown files and convert to DOCX for KDP
# This version properly handles System messages and KDP formatting requirements

$bookDir = "book1"
$outputMd = "book1-combined-kdp.md"
$outputDocx = "Fracture-Protocol-Path-of-Unintended-Consequence-KDP.docx"

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

# Function to clean System messages (remove code blocks, format for KDP)
function Format-SystemMessage {
    param([string]$content)
    
    # Replace triple backtick code blocks with formatted System messages
    # Pattern: ``` followed by text, then ```
    $content = $content -replace '(?s)```\s*\r?\n(.*?)\r?\n```', {
        param($match)
        $message = $match.Groups[1].Value.Trim()
        # Format as centered, all-caps System message
        # Use markdown formatting that will convert to proper DOCX
        return "`n`n[SYSTEM MESSAGE]`n$message`n[/SYSTEM MESSAGE]`n`n"
    }
    
    # Also handle single backticks that might be inline code
    # But keep them as-is if they're in the middle of sentences (like technical terms)
    # Only replace standalone backtick blocks
    
    return $content
}

# Create combined markdown file
$combinedContent = ""

foreach ($file in $files) {
    $filePath = Join-Path $bookDir $file
    
    if (Test-Path $filePath) {
        Write-Host "Processing: $file"
        $content = Get-Content $filePath -Raw
        
        # Format System messages
        $content = Format-SystemMessage -content $content
        
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

# Convert to DOCX with proper formatting
Write-Host "`nConverting to DOCX for KDP..."
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Pandoc command with KDP-friendly settings
$pandocArgs = @(
    $outputMd,
    "-o", $outputDocx,
    "--toc",                          # Table of contents
    "--toc-depth=2",                  # Only H1 and H2 in TOC
    "--standalone",                   # Standalone document
    "--wrap=none",                    # Don't wrap lines
    "-V", "geometry:margin=1in",      # 1 inch margins
    "-V", "fontsize=12pt",            # 12pt font
    "-V", "linestretch=1.5",          # 1.5 line spacing
    "--reference-doc=reference.docx"  # Use reference if available
)

# Try with reference doc first, then without
try {
    pandoc $pandocArgs
    if ($LASTEXITCODE -ne 0) {
        throw "Pandoc failed"
    }
} catch {
    Write-Host "Trying without reference document..."
    $pandocArgs = $pandocArgs[0..($pandocArgs.Length-3)] + $pandocArgs[-2..-1]
    pandoc $pandocArgs
}

if (Test-Path $outputDocx) {
    Write-Host "✓ DOCX file created: $outputDocx"
    Write-Host ""
    Write-Host "IMPORTANT: Open the DOCX file in Word and:"
    Write-Host "1. Find and replace '[SYSTEM MESSAGE]' and '[/SYSTEM MESSAGE]' markers"
    Write-Host "2. Format System messages as centered, all-caps text"
    Write-Host "3. Or use a text box/border for System messages"
    Write-Host "4. Remove any remaining backticks or markdown syntax"
    Write-Host "5. Check for any other formatting issues"
} else {
    Write-Warning "DOCX file was not created. Check for errors above."
}

Write-Host ""
Write-Host "Done!"

