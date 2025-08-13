#!/usr/bin/env bash
set -euo pipefail
sudo tee /etc/yum.repos.d/grafana.repo >/dev/null <<'EOF'
[grafana]
name=Grafana OSS
baseurl=https://packages.grafana.com/oss/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://packages.grafana.com/gpg.key
sslverify=1
EOF
sudo yum -y install grafana
sudo systemctl enable --now grafana-server
echo "Grafana installed: http://monitor:3000 (admin/admin)."
