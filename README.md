# Hadoop Administration Project — Monitoring with Prometheus & Grafana

## What you'll do
- Install **Apache Hadoop** (open-source binaries) on a 3-node lab.
- Expose metrics using **Node Exporter** (system) and **JMX Exporter** (Hadoop JVMs).
- Install **Prometheus**, **Alertmanager**, and **Grafana** on a monitor node.
- Configure Prometheus scrape jobs and alert rules.
- Build/Import Grafana dashboards and set up notifications (Slack/email).
- (Optional) Ship logs to **Loki** and visualize in Grafana Explore.

## Topology
- nn1: NameNode + ResourceManager (+ node_exporter + jmx_exporter)
- dn1: DataNode + NodeManager (+ node_exporter + jmx_exporter)
- dn2: DataNode + NodeManager (+ node_exporter + jmx_exporter)
- monitor: Prometheus + Alertmanager + Grafana

## Day-by-day
- **Day 1**: Hadoop install & bring-up (HDFS/YARN), web UIs, fsck/report.
- **Day 2**: Exporters + Prometheus + Grafana.
- **Day 3**: Dashboards + alerts, notification test fire.
- **Day 4**: Hardening, quotas/snapshots, final report.

## Quickstart
1) On all Hadoop nodes, install Java 11, create user `hadoop`, enable passwordless SSH.
2) Run `scripts/install_hadoop.sh` and copy `configs/*.xml` into `$HADOOP_HOME/etc/hadoop`.
3) Start HDFS+YARN and validate: NameNode UI 9870, RM UI 8088.
4) On each Hadoop node, install exporters: `scripts/install_node_exporter.sh` and add JMX exporter jar/agent using `jmx/` templates.
5) On **monitor**: run `scripts/install_prometheus.sh`, `scripts/install_grafana.sh`, `scripts/install_alertmanager.sh`.
6) Put `monitoring/prometheus.yml` & `monitoring/alerts.yml` in `/etc/prometheus/`. Start services.
7) In Grafana, add Prometheus data source (http://monitor:9090) and import dashboards from `grafana_dashboards/`.
8) Configure Alertmanager receivers in `monitoring/alertmanager.yml` and test alerts.
