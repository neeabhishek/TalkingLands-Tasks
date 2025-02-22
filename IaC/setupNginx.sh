#!/bin/bash

set -e
sudo apt update -y
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
echo "Deployed via Terraform." | sudo tee /var/www/html/index.html
