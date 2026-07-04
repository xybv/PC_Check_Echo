$ErrorActionPreference = "Stop"

$folder = "$env:LOCALAPPDATA\PC_Check_Echo"
$repo = "https://raw.githubusercontent.com/xybv/PC_Check_Echo/main"

$pyFile = "$folder\echo.py"
$reqFile = "$folder\requirements.txt"

# Create folder
New-Item -ItemType Directory -Force -Path $folder | Out-Null

Write-Host "[+] Downloading Python script..."
Invoke-WebRequest "$repo/echo.py" -OutFile $pyFile

Write-Host "[+] Downloading requirements..."
Invoke-WebRequest "$repo/requirements.txt" -OutFile $reqFile

Write-Host "[+] Installing requirements..."
pip install -r $reqFile

Write-Host "[+] Running script..."
python $pyFile
