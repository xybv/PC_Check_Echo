$ErrorActionPreference = "Continue"

$folder = Join-Path $env:LOCALAPPDATA "PC_Check_Echo"
$baseUrl = "https://raw.githubusercontent.com/xybv/PC_Check_Echo/refs/heads/main"

$pyFile = Join-Path $folder "echo.py"
$reqFile = Join-Path $folder "requirements.txt"

New-Item -ItemType Directory -Force -Path $folder | Out-Null

Write-Host "[+] Downloading files..."

Invoke-WebRequest "$baseUrl/echo.py" -OutFile $pyFile
Invoke-WebRequest "$baseUrl/requirements.txt" -OutFile $reqFile

Write-Host "[+] Finding Python..."

$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) { $python = Get-Command py -ErrorAction SilentlyContinue }

if (-not $python) {
    Write-Host "[-] Python not found (install it first)" -ForegroundColor Red
    pause
    exit
}

Write-Host "[+] Using: $($python.Source)"

Write-Host "[+] Installing requirements..."
& $python.Source -m pip install --upgrade pip
& $python.Source -m pip install -r $reqFile

Write-Host "[+] Running script..."

# 💀 THIS is the fix that actually makes it run
& $python.Source -u $pyFile

Write-Host "[+] Done"
pause
