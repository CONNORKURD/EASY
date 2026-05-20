# Millennium Steam Installer

if (-not $env:INSTALL_PATH -or -not (Test-Path $env:INSTALL_PATH)) {
    Write-Host "ERROR: No valid install location provided." -ForegroundColor Red
    exit 1
}

$dest = $env:INSTALL_PATH
$repo = "https://raw.githubusercontent.com/CONNORKURD/EASY/main"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Millennium Installer for Steam" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Install location: $dest" -ForegroundColor Cyan
Write-Host ""

$files = @(
    "millennium-legacy.version.dll",
    "millennium.dll",
    "millennium.hhx64.dll",
    "python311.dll",
    "wsock32.dll",
    "dwmapi.dll",
    "xinput1_4.dll"
)

foreach ($file in $files) {
    $url = "$repo/$file"
    $outPath = "$dest\$file"
    Write-Host "Downloading $file..." -ForegroundColor Yellow
    try {
        if (Test-Path $outPath) { Remove-Item $outPath -Force }
        Invoke-WebRequest -Uri $url -OutFile $outPath -UseBasicParsing
        Write-Host "$file - OK" -ForegroundColor Green
    } catch {
        Write-Host "Failed: $file" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Downloading ext.zip..." -ForegroundColor Yellow
try {
    if (Test-Path "$dest\ext.zip") { Remove-Item "$dest\ext.zip" -Force }
    Invoke-WebRequest -Uri "$repo/ext.zip" -OutFile "$dest\ext.zip" -UseBasicParsing
    Write-Host "Extracting ext.zip..." -ForegroundColor Yellow
    if (Test-Path "$dest\ext") { Remove-Item "$dest\ext" -Recurse -Force }
    Expand-Archive -Path "$dest\ext.zip" -DestinationPath "$dest" -Force
    Remove-Item "$dest\ext.zip" -Force
    Write-Host "ext folder - OK" -ForegroundColor Green
} catch {
    Write-Host "Failed to download/extract ext.zip" -ForegroundColor Red
}

Write-Host ""
Write-Host "Downloading plugins.zip..." -ForegroundColor Yellow
try {
    if (Test-Path "$dest\plugins.zip") { Remove-Item "$dest\plugins.zip" -Force }
    Invoke-WebRequest -Uri "$repo/plugins.zip" -OutFile "$dest\plugins.zip" -UseBasicParsing
    Write-Host "Extracting plugins.zip..." -ForegroundColor Yellow
    if (Test-Path "$dest\plugins") { Remove-Item "$dest\plugins" -Recurse -Force }
    Expand-Archive -Path "$dest\plugins.zip" -DestinationPath "$dest" -Force
    Remove-Item "$dest\plugins.zip" -Force
    Write-Host "plugins folder - OK" -ForegroundColor Green
} catch {
    Write-Host "Failed to download/extract plugins.zip" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Installation Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan