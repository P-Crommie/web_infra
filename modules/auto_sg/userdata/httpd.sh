#!/bin/bash

sudo hostnamectl set-hostname webApp

sleep 30

# Update package repository and install httpd
sudo apt update -y
sudo apt install -y apache2

# Start and enable httpd service
sudo systemctl start apache2
sudo systemctl enable apache2

sudo reboot