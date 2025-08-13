param([string]$Version="3.3.6")
$ErrorActionPreference = "Stop"
$dest="C:\hadoop"
New-Item -ItemType Directory -Force -Path $dest | Out-Null
$tgz="$env:TEMP\hadoop-$Version.tar.gz"
Invoke-WebRequest -Uri "https://downloads.apache.org/hadoop/common/hadoop-$Version/hadoop-$Version.tar.gz" -OutFile $tgz
# Expand .tar.gz using built-in tar
tar -xzf $tgz -C $env:TEMP
Move-Item "$env:TEMP\hadoop-$Version" "$dest\hadoop-$Version" -Force
[Environment]::SetEnvironmentVariable("HADOOP_HOME","$dest\hadoop-$Version","Machine")
$envPath = [Environment]::GetEnvironmentVariable("Path","Machine")
if ($envPath -notlike "*$dest\hadoop-$Version\bin*") {
  [Environment]::SetEnvironmentVariable("Path",$envPath + ";$dest\hadoop-$Version\bin;$dest\hadoop-$Version\sbin","Machine")
}
Write-Host "Hadoop $Version installed at $dest\hadoop-$Version"
