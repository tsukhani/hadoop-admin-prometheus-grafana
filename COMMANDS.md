## Hadoop bring-up
hdfs namenode -format
start-dfs.sh && start-yarn.sh
hdfs dfs -mkdir -p /data && hdfs dfsadmin -report

## Service checks
systemctl status prometheus alertmanager grafana-server node_exporter

## Prometheus test
curl -s http://monitor:9090/-/ready
curl -s http://nn1:9100/metrics | head
curl -s http://nn1:7000/metrics | head

## Alert test (heap rule): temporarily lower threshold in alerts.yml and reload
curl -X POST http://monitor:9090/-/reload
