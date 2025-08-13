$ver="9.5.15"
$dest="C:\Grafana"
New-Item -ItemType Directory -Force -Path $dest | Out-Null
Invoke-WebRequest -Uri "https://dl.grafana.com/oss/release/grafana-$ver.windows-amd64.zip" -OutFile "$env:TEMP\grafana.zip"
Expand-Archive "$env:TEMP\grafana.zip" -DestinationPath $dest -Force
if (-not (Get-Command nssm -ErrorAction SilentlyContinue)) {
  Invoke-WebRequest -Uri "https://nssm.cc/release/nssm-2.24.zip" -OutFile "$env:TEMP\nssm.zip"
  Expand-Archive "$env:TEMP\nssm.zip" -DestinationPath "C:\nssm" -Force
  $env:Path += ";C:\nssm\nssm-2.24\win64"
}
nssm install Grafana "C:\Grafana\bin\grafana-server.exe" " --homepath C:\Grafana"
nssm set Grafana AppExit Default Restart
nssm start Grafana
Write-Host "Grafana running at http://localhost:3000 (login: admin / admin)"
