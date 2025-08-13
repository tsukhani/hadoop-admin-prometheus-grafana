# JMX Exporter for Hadoop JVMs

1) Download jmx_prometheus_javaagent.jar (e.g., 0.20.0):
```
curl -fLO https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.20.0/jmx_prometheus_javaagent-0.20.0.jar
sudo mv jmx_prometheus_javaagent-0.20.0.jar /opt/jmx_exporter/
```
2) Copy `jmx_hadoop_config.yml` to `/opt/jmx_exporter/` and adjust as needed.
3) Edit Hadoop env scripts to add the javaagent:
- NameNode (`$HADOOP_HOME/etc/hadoop/hadoop-env.sh`):
```
export HADOOP_NAMENODE_OPTS="$HADOOP_NAMENODE_OPTS -javaagent:/opt/jmx_exporter/jmx_prometheus_javaagent-0.20.0.jar=7000:/opt/jmx_exporter/jmx_hadoop_config.yml"
```
- DataNode:
```
export HADOOP_DATANODE_OPTS="$HADOOP_DATANODE_OPTS -javaagent:/opt/jmx_exporter/jmx_prometheus_javaagent-0.20.0.jar=7001:/opt/jmx_exporter/jmx_hadoop_config.yml"
```
- ResourceManager:
```
export YARN_RESOURCEMANAGER_OPTS="$YARN_RESOURCEMANAGER_OPTS -javaagent:/opt/jmx_exporter/jmx_prometheus_javaagent-0.20.0.jar=7002:/opt/jmx_exporter/jmx_hadoop_config.yml"
```
- NodeManager:
```
export YARN_NODEMANAGER_OPTS="$YARN_NODEMANAGER_OPTS -javaagent:/opt/jmx_exporter/jmx_prometheus_javaagent-0.20.0.jar=7003:/opt/jmx_exporter/jmx_hadoop_config.yml"
```
4) Restart services and verify ports (7000-7003) are open and scraped by Prometheus.
