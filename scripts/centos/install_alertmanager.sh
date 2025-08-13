#!/usr/bin/env bash
set -euo pipefail
ALERTMAN_VERSION=${ALERTMAN_VERSION:-0.27.0}
cd /tmp
curl -fLO https://github.com/prometheus/alertmanager/releases/download/v${ALERTMAN_VERSION}/alertmanager-${ALERTMAN_VERSION}.linux-amd64.tar.gz
tar xzf alertmanager-${ALERTMAN_VERSION}.linux-amd64.tar.gz
sudo useradd --no-create-home --shell /sbin/nologin alertmanager || true
sudo mkdir -p /etc/alertmanager /var/lib/alertmanager
cd alertmanager-${ALERTMAN_VERSION}.linux-amd64
sudo cp alertmanager amtool /usr/local/bin/
sudo chown -R alertmanager:alertmanager /etc/alertmanager /var/lib/alertmanager
sudo tee /etc/systemd/system/alertmanager.service >/dev/null <<'EOF'
[Unit]
Description=Prometheus Alertmanager
Wants=network-online.target
After=network-online.target

[Service]
User=alertmanager
Group=alertmanager
Type=simple
ExecStart=/usr/local/bin/alertmanager   --config.file=/etc/alertmanager/alertmanager.yml   --storage.path=/var/lib/alertmanager
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
echo "Alertmanager installed. Create /etc/alertmanager/alertmanager.yml then: systemctl daemon-reload && systemctl enable --now alertmanager"
