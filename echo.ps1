$ErrorActionPreference = "Stop"

$folder = Join-Path $env:LOCALAPPDATA "PC_Check_Echo"

$pyUrl  = "https://raw.githubusercontent.com/xybv/PC_Check_Echo/refs/heads/main/echo.py"
$reqUrl = "https://raw.githubusercontent.com/xybv/PC_Check_Echo/refs/heads/main/requirements.txt"

$pyFile  = Join-Path $folder "echo.py"
$reqFile = Join-Path $folder "requirements.txt"

# Create folder
New-Item -ItemType Directory -Force -Path $folder | Out-Null

Write-Host "[+] Downloading files..."

Invoke-WebRequest -Uri $pyUrl -OutFile $pyFile
Invoke-WebRequest -Uri $reqUrl -OutFile $reqFile

# Check Python
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "[-] Python not found in PATH" -ForegroundColor Red
    exit 1
}

Write-Host "[+] Upgrading pip..."
python -m pip install --upgrade pip --quiet

Write-Host "[+] Installing requirements..."
python -m pip install --no-cache-dir -r $reqFile

Write-Host "[+] Running script..."
Start-Process python -ArgumentList "`"$pyFile`"" -WorkingDirectory $folder
