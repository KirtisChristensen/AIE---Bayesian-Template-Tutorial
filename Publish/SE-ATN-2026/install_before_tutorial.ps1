# ============================================================
# install_before_tutorial.ps1
# 2026 SE&ATN Symposium - AI-Driven Bayesian Templates Tutorial
# Run BEFORE the tutorial to install all dependencies.
#
# Usage:  Right-click -> Run with PowerShell
#         OR: powershell -ExecutionPolicy Bypass -File install_before_tutorial.ps1
# ============================================================

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " 2026 SE&ATN Tutorial - Pre-Install Script (Windows)" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# ── Detect conda ──────────────────────────────────────────────────────────────
$condaExe = $null
$candidates = @(
    (Get-Command conda -ErrorAction SilentlyContinue)?.Source,
    "$env:USERPROFILE\miniconda3\Scripts\conda.exe",
    "$env:USERPROFILE\anaconda3\Scripts\conda.exe",
    "C:\ProgramData\miniconda3\Scripts\conda.exe",
    "C:\ProgramData\Anaconda3\Scripts\conda.exe"
)
foreach ($c in $candidates) {
    if ($c -and (Test-Path $c)) { $condaExe = $c; break }
}

if ($condaExe) {
    Write-Host "Conda found: $condaExe" -ForegroundColor Green
    Write-Host ""
    Write-Host "Creating conda environment 'aie-workshop' from environment.yml ..."
    Write-Host "(This takes 5-10 minutes on first run — grab a coffee!)"
    Write-Host ""
    & $condaExe env create -f environment.yml --force
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Conda env create failed. Trying pip fallback..." -ForegroundColor Yellow
        & python -m pip install -r requirements.txt
    } else {
        Write-Host ""
        Write-Host "Registering Jupyter kernel ..." -ForegroundColor Cyan
        & $condaExe run -n aie-workshop python -m ipykernel install --user --name aie-workshop --display-name "Python (aie-workshop)"
        Write-Host ""
        Write-Host "SUCCESS! Run the tutorial with:" -ForegroundColor Green
        Write-Host "  conda activate aie-workshop" -ForegroundColor White
        Write-Host "  jupyter lab" -ForegroundColor White
    }
} else {
    Write-Host "Conda not found. Using pip with current Python..." -ForegroundColor Yellow
    $pythonExe = (Get-Command python -ErrorAction SilentlyContinue)?.Source
    if (-not $pythonExe) {
        Write-Host ""
        Write-Host "ERROR: Python not found." -ForegroundColor Red
        Write-Host "Please install Miniconda from: https://docs.conda.io/en/latest/miniconda.html"
        Write-Host "Then re-run this script."
        Read-Host "Press Enter to exit"
        exit 1
    }
    Write-Host "Python found: $pythonExe"
    Write-Host "Installing packages from requirements.txt ..."
    & python -m pip install -r requirements.txt
    if ($LASTEXITCODE -ne 0) {
        Write-Host "pip install failed. See errors above." -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
    Write-Host ""
    Write-Host "SUCCESS! Run the tutorial with:" -ForegroundColor Green
    Write-Host "  jupyter lab" -ForegroundColor White
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " Setup complete. See QUICKSTART.md for next steps." -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Read-Host "Press Enter to close"
