#!/bin/bash -e

# Setup Cosmovisor
echo "export DAEMON_NAME=gaiad" >> ~/.profile
echo "export DAEMON_HOME=/root/.gaia" >> ~/.profile
source ~/.profile

# Install cosmovisor
mkdir -p ~/.gaia/cosmovisor/upgrades
mkdir -p ~/.gaia/cosmovisor/genesis/bin/
cp $(which gaiad) ~/.gaia/cosmovisor/genesis/bin/

sleep infinity
