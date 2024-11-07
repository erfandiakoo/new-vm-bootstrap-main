#!/bin/bash

# Update apt package index
echo "Updating apt package index..."
sudo apt update
if [ $? -eq 0 ]; then
    echo "Apt package index updated successfully."
else
    echo "Error updating apt package index. Please check your internet connection and try again."
    exit 1
fi

# Install necessary packages
echo "Installing necessary packages..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
if [ $? -eq 0 ]; then
    echo "Packages installed successfully."
else
    echo "Error installing necessary packages."
    exit 1
fi

# Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
if [ $? -eq 0 ]; then
    echo "Docker's GPG key added successfully."
else
    echo "Error adding Docker's GPG key."
    exit 1
fi

# Add Docker repository to APT sources
echo "Adding Docker repository to APT sources..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
if [ $? -eq 0 ]; then
    echo "Docker repository added to APT sources successfully."
else
    echo "Error adding Docker repository to APT sources."
    exit 1
fi

# Update apt package index again
echo "Updating apt package index again..."
sudo apt update
if [ $? -eq 0 ]; then
    echo "Apt package index updated successfully."
else
    echo "Error updating apt package index. Please check your internet connection and try again."
    exit 1
fi

# Install Docker
echo "Installing Docker..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
if [ $? -eq 0 ]; then
    echo "Docker installed successfully."
else
    echo "Error installing Docker. Please check if the Docker repository is accessible."
    exit 1
fi





# Add current user to the docker group
echo "Adding current user to the docker group..."
sudo usermod -aG docker $USER
if [ $? -eq 0 ]; then
    echo "User added to the docker group successfully."
else
    echo "Error adding user to the docker group."
    exit 1
fi

# Print Docker version
echo "Docker version:"
docker --version
echo -e "{\n  \"registry-mirrors\": [\"https://registry.docker.ir\"],\n  \"insecure-registries\": [\"reg.bigdata.digikala.com\",\"docker.bigdata.digikala.com\"],\n  \"data-root\": \"/bigdata/docker-logs\",\n  \"default-address-pools\": [\n    {\"base\":\"192.168.0.0/16\",\"size\":22}\n  ]\n}" | sudo tee /etc/docker/daemon.json
systemctl restart docker.service
echo "Docker installation completed successfully."