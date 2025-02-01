#!/bin/bash

# Komponens telepites
cd ~
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.39.7/install.sh | bash
source ~/.profile
nvm install 20

# Munka mappa
cd /var/www

# Tisztitas
rm -rf trn-azure-webapp-sql

# App 
git clone https://github.com/cloudsteak/trn-azure-webapp-sql.git

# Kapcsolat
cp .env trn-azure-webapp-sql/

# App mappa
cd trn-azure-webapp-sql

# Telepites
npm install

# Start
npm start
