# Grading Rubric — Windows Hadoop 3.x + Prometheus/Grafana

**Hadoop bring-up (25 pts)**
- Hadoop 3.x installed (WSL2 or native), single-node running (15)
- Correct configs and UIs reachable (10)

**Metrics & Exporters (25 pts)**
- JMX exporter exposing NN/DN/RM/NM metrics (15)
- windows_exporter scraping host metrics (10)

**Prometheus & Grafana (20 pts)**
- Prometheus targets UP, data retained (10)
- Grafana dashboard imported and populated (10)

**Alerting (20 pts)**
- Alert rules configured; test notification delivered (email/Slack) (20)

**Report (10 pts)**
- 1–2 pages with screenshots, configs, and troubleshooting notes (10)
