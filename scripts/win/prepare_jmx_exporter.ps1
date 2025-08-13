New-Item -ItemType Directory -Force -Path C:\hadoop\jmx | Out-Null
Invoke-WebRequest -Uri https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.20.0/jmx_prometheus_javaagent-0.20.0.jar `
  -OutFile C:\hadoop\jmx\jmx_prometheus_javaagent.jar
@"
lowercaseOutputName: true
lowercaseOutputLabelNames: true
rules:
  - pattern: 'Hadoop<name=(.*), service=(.*)><>(\w+)'
    name: hadoop_$2_$3
    type: GAUGE
  - pattern: 'java.lang<type=Memory><>(\w+)'
    name: jvm_memory_$1_bytes
    type: GAUGE
  - pattern: 'java.lang<type=GarbageCollector, name=(.*)><>CollectionTime'
    name: jvm_gc_time_ms
    type: COUNTER
  - pattern: 'java.lang<type=Threading><>ThreadCount'
    name: jvm_threads
    type: GAUGE
"@ | Out-File C:\hadoop\jmx\jmx_hadoop_config.yml -Encoding utf8

$conf = "$env:HADOOP_HOME\etc\hadoop"
Add-Content "$conf\hadoop-env.cmd" 'set HADOOP_NAMENODE_OPTS=%HADOOP_NAMENODE_OPTS% -javaagent:C:\hadoop\jmx\jmx_prometheus_javaagent.jar=7000:C:\hadoop\jmx\jmx_hadoop_config.yml'
Add-Content "$conf\hadoop-env.cmd" 'set HADOOP_DATANODE_OPTS=%HADOOP_DATANODE_OPTS% -javaagent:C:\hadoop\jmx\jmx_prometheus_javaagent.jar=7001:C:\hadoop\jmx\jmx_hadoop_config.yml'
Add-Content "$conf\yarn-env.cmd" 'set YARN_RESOURCEMANAGER_OPTS=%YARN_RESOURCEMANAGER_OPTS% -javaagent:C:\hadoop\jmx\jmx_prometheus_javaagent.jar=7002:C:\hadoop\jmx\jmx_hadoop_config.yml'
Add-Content "$conf\yarn-env.cmd" 'set YARN_NODEMANAGER_OPTS=%YARN_NODEMANAGER_OPTS% -javaagent:C:\hadoop\jmx\jmx_prometheus_javaagent.jar=7003:C:\hadoop\jmx\jmx_hadoop_config.yml'

Write-Host "JMX exporter prepared. Restart Hadoop daemons after this step."
