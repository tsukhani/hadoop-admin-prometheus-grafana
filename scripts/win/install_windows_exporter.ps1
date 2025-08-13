$ver="0.25.1"
$msi="$env:TEMP\windows_exporter-$ver-amd64.msi"
Invoke-WebRequest -Uri "https://github.com/prometheus-community/windows_exporter/releases/download/v$ver/windows_exporter-$ver-amd64.msi" -OutFile $msi
Start-Process msiexec.exe -Wait -ArgumentList "/i `"$msi`" ENABLED_COLLECTORS=cpu,logical_disk,net,os,service LISTEN_PORT=9182 /qn"
Write-Host "windows_exporter listening on :9182"
