param([string]$Version='3.3.6')
$dest='C:\hadoop'
New-Item -ItemType Directory -Force -Path $dest | Out-Null
$zip="hadoop-$Version.tar.gz"
Invoke-WebRequest -Uri "https://downloads.apache.org/hadoop/common/hadoop-$Version/hadoop-$Version.tar.gz" -OutFile $zip
tar -xzf $zip
Move-Item "hadoop-$Version" "$dest\hadoop-$Version"
[Environment]::SetEnvironmentVariable('HADOOP_HOME',"$dest\hadoop-$Version",'Machine')
