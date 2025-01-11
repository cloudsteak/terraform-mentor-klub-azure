#!/bin/bash
# datetime
nowdate=$(date +"%Y/%m/%d %H:%M:%S")
version=$(lsb_release -a)
# hostname.html
sudo echo "<html><head><style>body{background-image: url('https://github.com/cloudsteak/azurestaticwebsite/blob/main/assets/images/laptop-gf2f68ed68_1920.jpg?raw=true');background-repeat: no-repeat;background-size: cover; background-position: center;color: whitesmoke;font-family: Verdana, Geneva, Tahoma, sans-serif;}</style></head><body><h1>Szerver neve: $(hostname)</h1><h3>Indult: $nowdate </h3><p>OS info: $version</p></body></html>" > /var/www/html/hostname.html

# index.html
sudo echo "<html><head><style>body{font-family: Verdana, Geneva, Tahoma, sans-serif;background-image: url('https://github.com/cloudsteak/azurestaticwebsite/blob/main/assets/images/laptop-gf2f68ed68_1920.jpg?raw=true');background-repeat: no-repeat;background-size: cover; background-position: center;color: whitesmoke;}</style></head><body><h1>Szerver neve: $(hostname)</h1><h3>Indult: $nowdate </h3><p>OS info: $version</p></body></html>" > /var/www/html/index.html
