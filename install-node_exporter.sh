#!/bin/bash
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz
tar xvf node_exporter-1.8.2.linux-amd64.tar.gz
cd node_exporter-1.8.2.linux-amd64/
cp node_exporter /usr/local/bin
groupadd node_exporter
useradd -m -g node_exporter node_exporter
chown -R node_exporter /usr/local/bin/node_exporter
echo -e "[Unit]\nDescription=Node Exporter\nWants=network-online.target\nAfter=network-online.target\n\n[Service]\nUser=node_exporter\nGroup=node_exporter\nType=simple\nExecStart=/usr/local/bin/node_exporter\nRestart=always\nRestartSec=3\n\n[Install]\nWantedBy=multi-user.target" | sudo tee /etc/systemd/system/node_exporter.service
sleep 2
systemctl daemon-reload
sleep 5
systemctl enable node_exporter
sleep 2
systemctl start node_exporter
sleep 5
curl localhost:9100/metrics