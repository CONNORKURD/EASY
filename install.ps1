# Millennium Steam Installer
# Automatically downloads and installs all files to C:\Program Files (x86)\Steam

$dest = "C:\Program Files (x86)\Steam"
$repo = "https://raw.githubusercontent.com/CONNORKURD/EASY/main"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Millennium Installer for Steam" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Individual files to download
$files = @(
    "millennium-legacy.version.dll",
    "millennium.dll",
    "millennium.hhx64.dll",
    "python311.dll",
    "Steam.cfg",
    "wsock32.dll",
    "xinput1_4.dll"
)

# Download individual files
foreach ($file in $files) {
    $url = "$repo/$file"
    $outPath = "$dest\$file"
    Write-Host "Downloading $file..." -ForegroundColor Yellow
    try {
        Invoke-WebRequest -Uri $url -OutFile $outPath -UseBasicParsing
        Write-Host "$file - OK" -ForegroundColor Green
    } catch {
        Write-Host "Failed: $file" -ForegroundColor Red
    }
}

# Download and extract ext.zip
Write-Host ""
Write-Host "Downloading ext.zip..." -ForegroundColor Yellow
try {
    Invoke-WebRequest -Uri "$repo/ext.zip" -OutFile "$dest\ext.zip" -UseBasicParsing
    Write-Host "Extracting ext.zip..." -ForegroundColor Yellow
    Expand-Archive -Path "$dest\ext.zip" -DestinationPath "$dest" -Force
    Remove-Item "$dest\ext.zip"
    Write-Host "ext folder - OK" -ForegroundColor Green
} catch {
    Write-Host "Failed to download/extract ext.zip" -ForegroundColor Red
}

# Download and extract plugins.zip
Write-Host ""
Write-Host "Downloading plugins.zip..." -ForegroundColor Yellow
try {
    Invoke-WebRequest -Uri "$repo/plugins.zip" -OutFile "$dest\plugins.zip" -UseBasicParsing
    Write-Host "Extracting plugins.zip..." -ForegroundColor Yellow
    Expand-Archive -Path "$dest\plugins.zip" -DestinationPath "$dest" -Force
    Remove-Item "$dest\plugins.zip"
    Write-Host "plugins folder - OK" -ForegroundColor Green
} catch {
    Write-Host "Failed to download/extract plugins.zip" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Installation Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
