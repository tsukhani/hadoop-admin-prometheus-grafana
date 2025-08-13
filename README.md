# Hadoop Administration Project — HDP 2.6.5 on CentOS with Prometheus & Grafana

This edition targets **Hortonworks Data Platform (HDP) 2.6.5** on **CentOS 7** (or compatible RHEL). 
It assumes **Ambari** manages Hadoop services (HDFS, YARN, Hive, etc.), and focuses on 
setting up a **Prometheus + Alertmanager + Grafana** monitoring stack with **Node Exporter** and **JMX Exporter**.

> HDP 2.6.5 typically uses **Java 8** and Hadoop 2.7.x. Service UIs: NameNode 50070, ResourceManager 8088.

## What you'll do
- Verify/bring up HDFS + YARN using **Ambari**.
- Install **Node Exporter** + **JMX Exporter** across HDP hosts (nn1, dn1, dn2).
- Install **Prometheus**, **Alertmanager**, **Grafana** on a **monitor** node (CentOS).
- Configure Prometheus scrape jobs and alert rules; wire **email/Slack** notifications.
- Import a starter **Grafana dashboard** and build a few custom panels.

## Topology
- nn1: NameNode + ResourceManager (+ node_exporter + jmx_exporter)
- dn1: DataNode + NodeManager (+ node_exporter + jmx_exporter)
- dn2: DataNode + NodeManager (+ node_exporter + jmx_exporter)
- monitor: Prometheus + Alertmanager + Grafana

## Quickstart (HDP/CentOS)
1) Confirm HDP services are healthy in **Ambari** (HDFS/YARN green). Java 1.8 is recommended.
2) On **each Hadoop host** (nn1/dn1/dn2), install exporters:
   ```bash
   sudo bash scripts/centos/install_node_exporter.sh
   sudo bash scripts/centos/prepare_jmx_exporter.sh
   # Edit /usr/hdp/current/*-env.sh via Ambari config to add -javaagent flags, then restart services.
   ```
3) On **monitor** host, install the monitoring stack:
   ```bash
   sudo bash scripts/centos/install_prometheus.sh
   sudo bash scripts/centos/install_alertmanager.sh
   sudo bash scripts/centos/install_grafana.sh
   ```
4) Copy configs and start services:
   ```bash
   sudo cp monitoring/prometheus.yml /etc/prometheus/prometheus.yml
   sudo cp monitoring/alerts.yml /etc/prometheus/alerts.yml
   sudo cp monitoring/alertmanager.yml /etc/alertmanager/alertmanager.yml
   sudo systemctl daemon-reload
   sudo systemctl enable --now prometheus alertmanager grafana-server
   ```
5) In Grafana (http://monitor:3000), add Prometheus datasource (http://monitor:9090) and import `grafana_dashboards/hdp265_hadoop_admin_core.json`.
