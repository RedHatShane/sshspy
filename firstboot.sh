#!/usr/bin/env bash

# Update apt and install dependencies
sudo apt-get update --yes && echo "Ran updates" >> /tmp/bootscript.log
sudo apt-get install ca-certificates curl --yes && echo "Installed curl and ca-certs" >> /tmp/bootscript.log

# Install Docker repository
sudo install -m 0755 -d /etc/apt/keyrings && echo "Created /etc/apt/keyrings " >> /tmp/bootscript.log
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && echo "Downloaded Docker key" >> /tmp/bootscript.log
sudo chmod a+r /etc/apt/keyrings/docker.asc && echo "Set read permission on Docker key" >> /tmp/bootscript.log
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && echo "Added repository" >> /tmp/bootscript.log

# Install Docker applications
sudo apt-get update --yes && echo "Ran updates" >> /tmp/bootscript.log
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin  --yes \
  && echo "Installed Docker stuff" >> /tmp/bootscript.log

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
