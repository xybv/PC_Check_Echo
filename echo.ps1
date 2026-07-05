$ErrorActionPreference = "Continue"

Write-Host "[+] Downloading script..."

$pyFile = Join-Path $env:TEMP "echo.py"

Invoke-WebRequest "https://raw.githubusercontent.com/xybv/PC_Check_Echo/refs/heads/main/echo.py" -OutFile $pyFile

Write-Host "[+] Checking Python..."

$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) { $python = Get-Command py -ErrorAction SilentlyContinue }

if (-not $python) {
    Write-Host "[-] Python not found on this system" -ForegroundColor Red
    pause
    exit
}

Write-Host "[+] Running script..."
Write-Host "-----------------------------"

try {
    & $python.Source $pyFile
} catch {
    Write-Host "[-] ERROR WHILE RUNNING PYTHON:" -ForegroundColor Red
    Write-Host $_
}

Write-Host "-----------------------------"
Write-Host "[+] Done"
pause
