$conf = "$env:HADOOP_HOME\etc\hadoop"
New-Item -ItemType Directory -Force -Path C:\hadoop\data\nn, C:\hadoop\data\dn | Out-Null

@"
<?xml version='1.0'?>
<configuration>
  <property><name>fs.defaultFS</name><value>hdfs://localhost:8020</value></property>
</configuration>
"@ | Out-File "$conf\core-site.xml" -Encoding utf8

@"
<?xml version='1.0'?>
<configuration>
  <property><name>dfs.replication</name><value>1</value></property>
  <property><name>dfs.namenode.name.dir</name><value>/c:/hadoop/data/nn</value></property>
  <property><name>dfs.datanode.data.dir</name><value>/c:/hadoop/data/dn</value></property>
</configuration>
"@ | Out-File "$conf\hdfs-site.xml" -Encoding utf8

@"
<?xml version='1.0'?>
<configuration>
  <property><name>yarn.nodemanager.aux-services</name><value>mapreduce_shuffle</value></property>
  <property><name>yarn.resourcemanager.hostname</name><value>localhost</value></property>
</configuration>
"@ | Out-File "$conf\yarn-site.xml" -Encoding utf8

@"
<?xml version='1.0'?>
<configuration>
  <property><name>mapreduce.framework.name</name><value>yarn</value></property>
</configuration>
"@ | Out-File "$conf\mapred-site.xml" -Encoding utf8

# Format NameNode
& "$env:HADOOP_HOME\bin\hdfs.cmd" namenode -format -force
Write-Host "Single-node Hadoop configuration complete."
