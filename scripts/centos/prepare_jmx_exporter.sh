#!/usr/bin/env bash
set -euo pipefail
VER=${VER:-0.20.0}
sudo mkdir -p /opt/jmx_exporter
cd /opt/jmx_exporter
sudo curl -fLO https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${VER}/jmx_prometheus_javaagent-${VER}.jar
sudo chown -R root:root /opt/jmx_exporter
echo "JMX exporter jar placed in /opt/jmx_exporter. Copy jmx_hadoop_config.yml and edit Ambari envs to add -javaagent flags."
