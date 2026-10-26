$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
Push-Location $repoRoot
try {
    py -m pip install -r updater/requirements.txt
    if ($LASTEXITCODE -ne 0) { throw 'Dependency installation failed' }
    py -m unittest discover -s updater/tests -v
    if ($LASTEXITCODE -ne 0) { throw 'Updater checks failed' }
    $themeData = (Join-Path $repoRoot 'Themes') + ';Themes'
    $brandData = (Join-Path $PSScriptRoot 'assets') + ';assets'
    $brandIcon = Join-Path $PSScriptRoot 'assets/kevindrc.ico'
    $versionFile = Join-Path $PSScriptRoot 'windows-version.txt'
    $catalogData = (Join-Path $repoRoot 'script-packages.json') + ';assets'
    py -m PyInstaller --noconfirm --onefile --windowed --name ThemeStudioForEthos --icon $brandIcon --version-file $versionFile --collect-all customtkinter --add-data $themeData --add-data $brandData --add-data $catalogData --distpath dist --workpath build/updater --specpath build updater/app.py
    if ($LASTEXITCODE -ne 0) { throw 'Windows app build failed' }
    Write-Host "Built: $repoRoot/dist/ThemeStudioForEthos.exe"
} finally {
    Pop-Location
}
