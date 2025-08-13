#!/usr/bin/env bash
set -euo pipefail
HADOOP_VERSION=${HADOOP_VERSION:-3.3.6}

sudo apt-get update && sudo apt-get install -y openjdk-11-jdk ssh rsync curl tar
echo "export JAVA_HOME=$(readlink -f /usr/bin/java | sed 's:/bin/java::')" | sudo tee -a /etc/environment
source /etc/environment || true

mkdir -p $HOME/hadoop-wsl
cd $HOME/hadoop-wsl
curl -fLO https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz
tar xzf hadoop-${HADOOP_VERSION}.tar.gz
mv hadoop-${HADOOP_VERSION} hadoop

cat >> ~/.bashrc <<'EOF'
export HADOOP_HOME=$HOME/hadoop-wsl/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")
EOF

source ~/.bashrc
echo "[OK] Hadoop ${HADOOP_VERSION} unpacked at $HOME/hadoop-wsl/hadoop"
