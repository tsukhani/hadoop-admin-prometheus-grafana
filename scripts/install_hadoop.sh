#!/usr/bin/env bash
set -euo pipefail
HADOOP_VERSION=${HADOOP_VERSION:-3.3.6}
INSTALL_DIR=${INSTALL_DIR:-/opt/hadoop}
sudo apt-get update && sudo apt-get install -y openjdk-11-jdk ssh rsync curl
if [ ! -d "$INSTALL_DIR" ]; then
  curl -fLO https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz
  sudo tar -xzf hadoop-${HADOOP_VERSION}.tar.gz -C /opt/
  sudo mv /opt/hadoop-${HADOOP_VERSION} ${INSTALL_DIR}
  sudo chown -R $USER:$USER ${INSTALL_DIR}
fi
grep -q HADOOP_HOME ~/.bashrc || cat >> ~/.bashrc <<'EOF'
export JAVA_HOME=$(readlink -f /usr/bin/java | sed 's:/bin/java::')
export HADOOP_HOME=/opt/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
EOF
echo "Install complete. Configure XML files and format NameNode."
