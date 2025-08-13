Start-Process -NoNewWindow -FilePath "$env:HADOOP_HOME\sbin\start-dfs.cmd"
Start-Process -NoNewWindow -FilePath "$env:HADOOP_HOME\sbin\start-yarn.cmd"
