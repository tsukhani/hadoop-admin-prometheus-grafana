#!/usr/bin/env bash
set -euo pipefail
CONF=$HOME/hadoop-wsl/hadoop/etc/hadoop

mkdir -p $HOME/hadoop-wsl/data/nn $HOME/hadoop-wsl/data/dn

cat > $CONF/core-site.xml <<'XML'
<?xml version="1.0"?>
<configuration>
  <property><name>fs.defaultFS</name><value>hdfs://localhost:8020</value></property>
</configuration>
XML

cat > $CONF/hdfs-site.xml <<'XML'
<?xml version="1.0"?>
<configuration>
  <property><name>dfs.replication</name><value>1</value></property>
  <property><name>dfs.namenode.name.dir</name><value>file:///home/USER_REPLACE/hadoop-wsl/data/nn</value></property>
  <property><name>dfs.datanode.data.dir</name><value>file:///home/USER_REPLACE/hadoop-wsl/data/dn</value></property>
</configuration>
XML
sed -i "s/USER_REPLACE/$USER/g" $CONF/hdfs-site.xml

cat > $CONF/yarn-site.xml <<'XML'
<?xml version="1.0"?>
<configuration>
  <property><name>yarn.nodemanager.aux-services</name><value>mapreduce_shuffle</value></property>
  <property><name>yarn.resourcemanager.hostname</name><value>localhost</value></property>
</configuration>
XML

cat > $CONF/mapred-site.xml <<'XML'
<?xml version="1.0"?>
<configuration>
  <property><name>mapreduce.framework.name</name><value>yarn</value></property>
</configuration>
XML

# JMX exporter config & agent
mkdir -p $HOME/hadoop-wsl/jmx
curl -fLo $HOME/hadoop-wsl/jmx/jmx_prometheus_javaagent.jar \
  https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.20.0/jmx_prometheus_javaagent-0.20.0.jar
cat > $HOME/hadoop-wsl/jmx/jmx_hadoop_config.yml <<'YML'
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
YML

# Inject javaagent flags
sed -i '/^# export HADOOP_NAMENODE_OPTS/ a export HADOOP_NAMENODE_OPTS="$HADOOP_NAMENODE_OPTS -javaagent:'"$HOME"'/hadoop-wsl/jmx/jmx_prometheus_javaagent.jar=7000:'"$HOME"'/hadoop-wsl/jmx/jmx_hadoop_config.yml"' $CONF/hadoop-env.sh || true
sed -i '/^# export HADOOP_DATANODE_OPTS/ a export HADOOP_DATANODE_OPTS="$HADOOP_DATANODE_OPTS -javaagent:'"$HOME"'/hadoop-wsl/jmx/jmx_prometheus_javaagent.jar=7001:'"$HOME"'/hadoop-wsl/jmx/jmx_hadoop_config.yml"' $CONF/hadoop-env.sh || true
echo 'export YARN_RESOURCEMANAGER_OPTS="$YARN_RESOURCEMANAGER_OPTS -javaagent:'"$HOME"'/hadoop-wsl/jmx/jmx_prometheus_javaagent.jar=7002:'"$HOME"'/hadoop-wsl/jmx/jmx_hadoop_config.yml"' >> $CONF/yarn-env.sh
echo 'export YARN_NODEMANAGER_OPTS="$YARN_NODEMANAGER_OPTS -javaagent:'"$HOME"'/hadoop-wsl/jmx/jmx_prometheus_javaagent.jar=7003:'"$HOME"'/hadoop-wsl/jmx/jmx_hadoop_config.yml"' >> $CONF/yarn-env.sh

$HOME/hadoop-wsl/hadoop/bin/hdfs namenode -format -force
echo "[OK] Single-node config complete. Start with: start-dfs.sh && start-yarn.sh"
