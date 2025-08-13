$target="$env:HADOOP_HOME\bin\winutils.exe"
Invoke-WebRequest -Uri https://github.com/steveloughran/winutils/raw/master/hadoop-3.3.6/bin/winutils.exe -OutFile $target
