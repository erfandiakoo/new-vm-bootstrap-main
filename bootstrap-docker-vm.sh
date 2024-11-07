#!/bin/bash
bash crony.sh

bash install-node_exporter.sh

clear

bash install-docker.sh

clear
echo "Done"
sleep 3