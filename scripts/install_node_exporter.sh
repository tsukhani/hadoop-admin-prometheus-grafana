#!/usr/bin/env bash
set -euo pipefail
VER=${VER:-1.8.1}
cd /tmp
curl -fLO https://github.com/prometheus/node_exporter/releases/download/v${VER}/node_exporter-${VER}.linux-amd64.tar.gz
tar xzf node_exporter-${VER}.linux-amd64.tar.gz
sudo cp node_exporter-${VER}.linux-amd64/node_exporter /usr/local/bin/
sudo useradd --no-create-home --shell /usr/sbin/nologin nodeexp || true
sudo tee /etc/systemd/system/node_exporter.service >/dev/null <<'EOF'
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=nodeexp
Group=nodeexp
Type=simple
ExecStart=/usr/local/bin/node_exporter
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
echo "Enable service with: sudo systemctl daemon-reload && sudo systemctl enable --now node_exporter"
