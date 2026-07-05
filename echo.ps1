$ErrorActionPreference = "Stop"

$folder = Join-Path $env:LOCALAPPDATA "PC_Check_Echo"

$baseUrl = "https://raw.githubusercontent.com/xybv/PC_Check_Echo/refs/heads/main"

$pyUrl  = "$baseUrl/echo.py"
$reqUrl = "$baseUrl/requirements.txt"

$pyFile  = Join-Path $folder "echo.py"
$reqFile = Join-Path $folder "requirements.txt"

# Create folder
New-Item -ItemType Directory -Force -Path $folder | Out-Null

Write-Host "[+] Downloading files..."

Invoke-WebRequest -Uri $pyUrl -OutFile $pyFile
Invoke-WebRequest -Uri $reqUrl -OutFile $reqFile

# Check Python
$python = Get-Command python -ErrorAction SilentlyContinue

if (-not $python) {
    Write-Host "[-] Python not found. Install Python and add to PATH." -ForegroundColor Red
    exit 1
}

Write-Host "[+] Upgrading pip..."
& python -m pip install --upgrade pip --quiet

Write-Host "[+] Installing requirements..."
& python -m pip install --no-cache-dir -r $reqFile

Write-Host "[+] Running script..."

Start-Process -FilePath $python.Source -ArgumentList "`"$pyFile`"" -WorkingDirectory $folder -Wait
