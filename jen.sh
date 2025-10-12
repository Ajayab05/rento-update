#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Updating system..."
sudo apt update -y
sudo apt upgrade -y

echo "Installing Java (OpenJDK 17)..."
sudo apt install -y openjdk-17-jdk

# Verify Java installation
java -version

echo "Adding Jenkins repository key and source..."
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

echo "Updating package list..."
sudo apt update -y

echo "Installing Jenkins..."
sudo apt install -y jenkins

echo "Starting and enabling Jenkins service..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "Checking Jenkins status..."
sudo systemctl status jenkins

echo "Jenkins installation completed!"
echo "Access Jenkins at: http://<your-server-ip>:8080"
echo "To get the initial admin password, run:"
echo "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"

