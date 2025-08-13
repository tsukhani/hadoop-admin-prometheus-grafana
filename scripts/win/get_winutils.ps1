# Educational-only: fetch winutils.exe for Hadoop 3.3.6 (community build)
$target="$env:HADOOP_HOME\bin\winutils.exe"
if (Test-Path $target) { Write-Host "winutils.exe already present"; exit 0 }
$repo="https://github.com/steveloughran/winutils/raw/master/hadoop-3.3.6/bin/winutils.exe"
Invoke-WebRequest -Uri $repo -OutFile $target
Write-Host "winutils.exe placed in $env:HADOOP_HOME\bin"
