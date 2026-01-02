# Script to fix markdown files for KDP conversion
# Removes code block markers and formats System messages properly

$bookDir = "book1"
$tempDir = "book1-kdp-temp"

# Create temp directory
if (Test-Path $tempDir) {
    Remove-Item $tempDir -Recurse -Force
}
New-Item -ItemType Directory -Path $tempDir | Out-Null

# Get all markdown files
$files = Get-ChildItem -Path $bookDir -Filter "*.md"

foreach ($file in $files) {
    Write-Host "Processing: $($file.Name)"
    
    $content = Get-Content $file.FullName -Raw
    
    # Fix System messages: Remove code block markers
    # Pattern: ``` followed by newline, then System message text, then ``` followed by newline
    # Use a simpler approach - replace the pattern directly
    $pattern = '(?s)```\s*\r?\n(.*?)\r?\n```'
    
    while ($content -match $pattern) {
        $message = $matches[1].Trim()
        $replacement = "`n`n[SYSTEM]`n$message`n[/SYSTEM]`n`n"
        $content = $content -replace [regex]::Escape($matches[0]), $replacement
    }
    
    # Write fixed file to temp directory
    $outputPath = Join-Path $tempDir $file.Name
    $content | Out-File -FilePath $outputPath -Encoding UTF8 -NoNewline
}

Write-Host "`nFixed files saved to: $tempDir"
Write-Host "Now run: .\convert-to-docx-kdp-fixed.ps1"
