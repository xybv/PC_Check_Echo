$ErrorActionPreference = "Stop"

$folder = "$env:LOCALAPPDATA\PC_Check_Echo"
$repo = "https://raw.githubusercontent.com/xybv/PC_Check_Echo/main"

$pyFile = Join-Path $folder "echo.py"
$reqFile = Join-Path $folder "requirements.txt"

# Create folder
New-Item -ItemType Directory -Force -Path $folder | Out-Null

Write-Host "[+] Downloading files..."

Invoke-WebRequest "$repo/echo.py" -OutFile $pyFile
Invoke-WebRequest "$repo/requirements.txt" -OutFile $reqFile

# Check Python
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "[-] Python not found in PATH" -ForegroundColor Red
    exit
}

# Upgrade pip (avoids install bugs)
Write-Host "[+] Upgrading pip..."
python -m pip install --upgrade pip --quiet

# Install requirements safely
Write-Host "[+] Installing requirements..."
python -m pip install --no-cache-dir -r $reqFile

# Run script
Write-Host "[+] Running script..."
Start-Process python -ArgumentList "`"$pyFile`""
