## Ambari (service restarts after env changes)
# Use Ambari UI to Save configs & Restart affected components

## Verify exporters
systemctl status node_exporter
curl -s http://nn1:7000/metrics | head
curl -s http://dn1:9100/metrics | head

## Prometheus/Grafana/Alertmanager
systemctl status prometheus alertmanager grafana-server
curl -s http://monitor:9090/-/ready
curl -s http://monitor:9093/api/v2/status

## Alert test
curl -X POST http://monitor:9090/-/reload
