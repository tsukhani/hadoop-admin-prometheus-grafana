$dest="C:\Prometheus"
New-Item -ItemType Directory -Force -Path $dest | Out-Null
$ver="2.53.0"
Invoke-WebRequest -Uri "https://github.com/prometheus/prometheus/releases/download/v$ver/prometheus-$ver.windows-amd64.zip" -OutFile "$env:TEMP\prom.zip"
Expand-Archive "$env:TEMP\prom.zip" -DestinationPath $dest -Force
if (Test-Path "$dest\prometheus-$ver.windows-amd64") { Move-Item "$dest\prometheus-$ver.windows-amd64\*" $dest -Force }
# Install as service via NSSM
if (-not (Get-Command nssm -ErrorAction SilentlyContinue)) {
  Invoke-WebRequest -Uri "https://nssm.cc/release/nssm-2.24.zip" -OutFile "$env:TEMP\nssm.zip"
  Expand-Archive "$env:TEMP\nssm.zip" -DestinationPath "C:\nssm" -Force
  $env:Path += ";C:\nssm\nssm-2.24\win64"
}
nssm install Prometheus "C:\Prometheus\prometheus.exe" " --config.file=C:\Prometheus\prometheus.yml"
nssm set Prometheus AppExit Default Restart
nssm start Prometheus
Write-Host "Prometheus installed as a Windows service on http://localhost:9090"
