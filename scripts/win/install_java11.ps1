# Requires Chocolatey. If missing, install: Set-ExecutionPolicy Bypass -Scope Process -Force; iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
choco install -y temurin11
$java = Get-ChildItem "C:\Program Files\Eclipse Adoptium" -Directory | Sort-Object LastWriteTime -Descending | Select-Object -First 1
$javaHome = Join-Path $java.FullName "jdk-11*"
$envPath = [Environment]::GetEnvironmentVariable("Path","Machine")
[Environment]::SetEnvironmentVariable("JAVA_HOME",$java.FullName,"Machine")
[Environment]::SetEnvironmentVariable("Path",$envPath + ";$($java.FullName)\bin","Machine")
Write-Host "Java 11 installed. JAVA_HOME=$($java.FullName)"
