$dest="C:\Alertmanager"
New-Item -ItemType Directory -Force -Path $dest | Out-Null
$ver="0.27.0"
Invoke-WebRequest -Uri "https://github.com/prometheus/alertmanager/releases/download/v$ver/alertmanager-$ver.windows-amd64.zip" -OutFile "$env:TEMP\am.zip"
Expand-Archive "$env:TEMP\am.zip" -DestinationPath $dest -Force
if (Test-Path "$dest\alertmanager-$ver.windows-amd64") { Move-Item "$dest\alertmanager-$ver.windows-amd64\*" $dest -Force }
if (-not (Get-Command nssm -ErrorAction SilentlyContinue)) {
  Invoke-WebRequest -Uri "https://nssm.cc/release/nssm-2.24.zip" -OutFile "$env:TEMP\nssm.zip"
  Expand-Archive "$env:TEMP\nssm.zip" -DestinationPath "C:\nssm" -Force
  $env:Path += ";C:\nssm\nssm-2.24\win64"
}
nssm install Alertmanager "C:\Alertmanager\alertmanager.exe" " --config.file=C:\Alertmanager\alertmanager.yml"
nssm set Alertmanager AppExit Default Restart
nssm start Alertmanager
Write-Host "Alertmanager installed as a service on http://localhost:9093"
