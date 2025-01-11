# !/bin/bash
# Description: Install apache2
sudo apt update
sudo apt install apache2 -y
sudo systemctl status apache2
sudo systemctl enable apache2


# Path: scripts/mentor.sh
mv mentor.sh /usr/local/bin/mentor.sh
chmod 744 /usr/local/bin/mentor.sh
chmod +x /usr/local/bin/mentor.sh

# Path: scripts/mentor.service
mv mentor.service /etc/systemd/system/mentor.service
chmod 644 /etc/systemd/system/mentor.service
cd /etc/systemd/system/
systemctl daemon-reload
systemctl enable mentor.service
systemctl restart mentor.service


# Wait for the mentor service to start
sleep 10
