# Hadoop Administration Project — Windows (Hadoop 3.x) + Prometheus/Grafana — FULL EDITION

This project teaches Hadoop administration on a **single Windows 10/11 machine** with **Hadoop 3.x**.
You’ll set up Hadoop (pseudo-distributed), instrument JVMs with **JMX Exporter**, collect OS metrics via **windows_exporter**,
and run **Prometheus**, **Alertmanager**, and **Grafana** on Windows.

Two install paths are provided:
1) **Recommended**: Windows with **WSL2 (Ubuntu)** to run Hadoop in Linux. Prometheus/Grafana stay on Windows.
2) **Native Windows** (educational): Run Hadoop directly on Windows using `winutils.exe` and PowerShell scripts.

> Production deployments should use Linux; Windows path is for learning/admin practice.

---

## Learning Objectives
- Install and configure Hadoop 3.x (single node, pseudo-distributed).
- Wire **JMX Exporter** to NameNode, DataNode, ResourceManager, NodeManager.
- Install **windows_exporter** and scrape system metrics.
- Install and configure **Prometheus** + **Alertmanager** + **Grafana** on Windows.
- Build dashboards and set up alert notifications (email/Slack).

## Topology & Ports
- Hadoop UIs: NameNode 9870, ResourceManager 8088
- Prometheus: 9090, Alertmanager: 9093, Grafana: 3000
- JMX Exporter ports: 7000 (NN), 7001 (DN), 7002 (RM), 7003 (NM)
- windows_exporter: 9182

---

## Quickstart Paths

### Path A — WSL2 (Recommended)
1. Enable WSL2 and install Ubuntu:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\scripts\win\enable_wsl2.ps1
   powershell -ExecutionPolicy Bypass -File .\scripts\win\install_wsl_ubuntu.ps1
   ```
2. Inside Ubuntu (first-run completes setup):
   ```bash
   bash ~/hadoop-wsl/scripts/linux/install_hadoop_ubuntu.sh
   bash ~/hadoop-wsl/scripts/linux/configure_hadoop_single_node.sh
   start-dfs.sh && start-yarn.sh
   ```
3. Download JMX agent and enable it (already scripted in config step).
4. On Windows, install monitoring stack:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\scripts\win\install_prometheus.ps1
   powershell -ExecutionPolicy Bypass -File .\scripts\win\install_alertmanager.ps1
   powershell -ExecutionPolicy Bypass -File .\scripts\win\install_grafana.ps1
   powershell -ExecutionPolicy Bypass -File .\scripts\win\install_windows_exporter.ps1
   ```
5. Copy `monitoring\prometheus.yml`, `alerts.yml`, `alertmanager.yml` to `C:\Prometheus\` and `C:\Alertmanager\`.
6. In Grafana (http://localhost:3000), add data source `http://localhost:9090` and import dashboard `grafana_dashboards\hadoop_windows_core.json`.

### Path B — Native Windows (Educational)
1. Install Java 11 and Hadoop 3.x:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\scripts\win\install_java11.ps1
   powershell -ExecutionPolicy Bypass -File .\scripts\win\install_hadoop3.ps1 -Version 3.3.6
   powershell -ExecutionPolicy Bypass -File .\scripts\win\get_winutils.ps1
   powershell -ExecutionPolicy Bypass -File .\scripts\win\configure_hadoop_single_node.ps1
   ```
2. Download JMX agent and config:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\scripts\win\prepare_jmx_exporter.ps1
   ```
3. Start Hadoop:
   ```powershell
   .\scripts\win\start_hadoop.ps1
   ```
4. Install Prometheus/Grafana/Alertmanager/windows_exporter (same as Path A step 4).

---

## Deliverables
- Screenshots: Hadoop UIs, Prometheus targets (all UP), Grafana dashboard with data, alert notification sample.
- Config snippets: `hadoop-env.cmd`/`yarn-env.cmd` javaagent lines, Prometheus/Alertmanager configs.
- Short report (1–2 pages) with issues & fixes.

## Grading Rubric
See `rubric/rubric.md`.
