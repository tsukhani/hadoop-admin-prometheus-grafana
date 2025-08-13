#!/usr/bin/env bash
set -euo pipefail
sudo apt-get update && sudo apt-get install -y apt-transport-https software-properties-common wget gnupg
wget -q -O - https://packages.grafana.com/gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/grafana.gpg
echo "deb [signed-by=/usr/share/keyrings/grafana.gpg] https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
sudo apt-get update && sudo apt-get install -y grafana
sudo systemctl enable --now grafana-server
echo "Grafana installed: http://monitor:3000 (admin/admin)."
