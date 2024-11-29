#!/usr/bin/env bash

# Update apt and install dependencies
sudo apt-get update 
sudo apt-get install ca-certificates curl

# Install Docker repository
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker applications
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo 'Script executed successfully!' >> /run/testing.txt

# Basic UFW rules with some random ports
ufw enable
ufw allow from 68.0.0.0/8 to any 
ufw allow from 172.17.0.0/16 to any
ufw allow from any to any port 22 proto tcp
ufw allow from any to any port 2222 proto tcp
ufw allow from any to any port 2244 proto tcp
ufw allow from any to any port 80 proto tcp
ufw allow from any to any port 443 proto tcp
ufw allow from any to any port 5000 proto tcp
