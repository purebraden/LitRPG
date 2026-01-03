# Script to combine Book 3 markdown files and convert to DOCX for KDP
# Includes map image and table of contents
# Book Title: Weaponized Normalization

$bookDir = "book3"
$tempDir = "book3-kdp-temp"
$outputMd = "book3-combined-kdp-final.md"
$outputDocx = "Fracture-Protocol-Weaponized-Normalization-KDP-FINAL.docx"
$bookTitle = "Weaponized Normalization"

# Clean up temp directory
if (Test-Path $tempDir) {
    Remove-Item $tempDir -Recurse -Force
}
New-Item -ItemType Directory -Path $tempDir | Out-Null

# Copy image to temp directory so it can be referenced
$imageSource = Join-Path (Get-Location) "images\harmony-map.png"
$imageDest = Join-Path $tempDir "harmony-map.png"
if (Test-Path $imageSource) {
    Copy-Item $imageSource $imageDest -Force
    Write-Host "Copied map image to temp directory"
} else {
    Write-Warning "Map image not found: $imageSource"
}

# Define the order of files (map.md goes after title, before prologue)
$files = @(
    "map.md",
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
    "chapter19_Interlude_A_System_Log_Alignment.md",
    "chapter20.md",
    "chapter20_Interlude_B_System_Log_Observer.md",
    "chapter21.md",
    "chapter21_Interlude_C_System_Log_Integrity.md",
    "chapter21_Interlude_D_System_Log_Human_Factor.md",
    "chapter22.md",
    "chapter23.md",
    "chapter24.md",
    "epilogue.md"
)

# Process each file to fix System messages and ensure UTF-8 encoding
foreach ($file in $files) {
    $filePath = Join-Path $bookDir $file
    
    if (Test-Path $filePath) {
        Write-Host "Processing: $file"
        
        # Read with UTF-8 encoding
        $content = Get-Content $filePath -Raw -Encoding UTF8
        
        # Fix image path in map.md to reference the copied image in temp directory
        if ($file -eq "map.md" -or $file -eq "MAP.md") {
            $content = $content -replace '\.\./images/harmony-map\.png', 'harmony-map.png'
            $content = $content -replace 'images/harmony-map\.png', 'harmony-map.png'
        }
        # Fix System messages: Remove code block markers
        $pattern = '(?s)```\s*\r?\n(.*?)\r?\n```'
        while ($content -match $pattern) {
            $message = $matches[1].Trim()
            $replacement = "`n`n[SYSTEM]`n$message`n[/SYSTEM]`n`n"
            $content = $content -replace [regex]::Escape($matches[0]), $replacement
        }
        
        # Remove trailing blank lines
        $content = $content -replace '\s+$', ''
        
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

# Add title page
$combinedContent += "# $bookTitle`n`n"
$combinedContent += "**Fracture Protocol: Book 3**`n`n"
$combinedContent += "---`n`n"

foreach ($file in $files) {
    $filePath = Join-Path $tempDir $file
    
    if (Test-Path $filePath) {
        Write-Host "Adding: $file"
        $content = [System.IO.File]::ReadAllText($filePath, [System.Text.UTF8Encoding]::new($false))
        
        # Remove leading/trailing whitespace from content
        $content = $content.Trim()
        
        # Add page break before each new section (except first)
        if ($combinedContent -ne "") {
            $combinedContent += "`n`n---`n`n"
        }
        
        $combinedContent += $content
    }
}

# Clean up excessive blank lines (more than 2 consecutive)
$combinedContent = $combinedContent -replace '(\r?\n){3,}', "`n`n"

# Write combined file with UTF-8 encoding
[System.IO.File]::WriteAllText($outputMd, $combinedContent, [System.Text.UTF8Encoding]::new($false))
Write-Host "`nCombined markdown file created: $outputMd"

# Convert to DOCX with proper encoding handling
Write-Host "`nConverting to DOCX for KDP..."
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Pandoc command with UTF-8, table of contents, and image support
# --toc creates a table of contents
# --toc-depth=2 includes chapters and major sections
# --standalone creates a complete document
# --wrap=none preserves line breaks
# --resource-path tells pandoc where to find images
$resourcePath = (Resolve-Path $tempDir).Path

# Check if pandoc is available
try {
    $null = Get-Command pandoc -ErrorAction Stop
} catch {
    Write-Error "Pandoc is not installed or not in PATH. Please install pandoc from https://pandoc.org/installing.html"
    exit 1
}

# Run pandoc with proper error handling
$pandocResult = & pandoc $outputMd -o $outputDocx --from=markdown+smart --to=docx --toc --toc-depth=2 --standalone --wrap=none --preserve-tabs --resource-path="$resourcePath" 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Error "Pandoc conversion failed with exit code $LASTEXITCODE"
    Write-Error $pandocResult
    exit 1
}

if (Test-Path $outputDocx) {
    Write-Host "DOCX file created: $outputDocx"
    Write-Host ""
    Write-Host "NEXT STEPS:"
    Write-Host "1. Open the DOCX file in Microsoft Word"
    Write-Host "2. Verify the map image appears correctly"
    Write-Host "3. Fix System messages (see KDP_FORMATTING_GUIDE.md)"
    Write-Host "4. Update Table of Contents:"
    Write-Host "   - Right-click the TOC → Update Field → Update entire table"
    Write-Host "   - Or delete TOC and insert new: References → Table of Contents"
    Write-Host "5. Check for encoding issues - em dashes, quotes, etc."
} else {
    Write-Warning "DOCX file was not created. Check for errors above."
}

Write-Host ""
Write-Host "Done!"

