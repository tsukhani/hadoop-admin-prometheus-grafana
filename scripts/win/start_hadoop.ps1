Start-Process -NoNewWindow -FilePath "$env:HADOOP_HOME\sbin\start-dfs.cmd"
Start-Process -NoNewWindow -FilePath "$env:HADOOP_HOME\sbin\start-yarn.cmd"
Write-Host "Started HDFS and YARN. Open http://localhost:9870 and http://localhost:8088"
