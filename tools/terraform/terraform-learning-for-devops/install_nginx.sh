#!/bin/bash  

sudo apt-get update  # update package lists
sudo apt-get install -y nginx # install nginx
sudo systemctl start nginx  # start nginx service
sudo systemctl enable nginx # enable nginx to start on boot


echo "<h1>Nginx is installed and running</h1>" > /var/www/html/index.html # create a simple HTML page to confirm nginx is running