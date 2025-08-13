#!/usr/bin/env bash
set -euo pipefail
PROM_VERSION=${PROM_VERSION:-2.53.0}
cd /tmp
curl -fLO https://github.com/prometheus/prometheus/releases/download/v${PROM_VERSION}/prometheus-${PROM_VERSION}.linux-amd64.tar.gz
tar xzf prometheus-${PROM_VERSION}.linux-amd64.tar.gz
sudo useradd --no-create-home --shell /sbin/nologin prometheus || true
sudo mkdir -p /etc/prometheus /var/lib/prometheus
cd prometheus-${PROM_VERSION}.linux-amd64
sudo cp prometheus promtool /usr/local/bin/
sudo cp -r consoles console_libraries /etc/prometheus/
sudo chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus
sudo tee /etc/systemd/system/prometheus.service >/dev/null <<'EOF'
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus   --config.file=/etc/prometheus/prometheus.yml   --storage.tsdb.path=/var/lib/prometheus   --web.console.templates=/etc/prometheus/consoles   --web.console.libraries=/etc/prometheus/console_libraries
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
echo "Prometheus installed. Copy configs then: systemctl daemon-reload && systemctl enable --now prometheus"
