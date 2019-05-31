#!/bin/bash
SOURCE_FOLDER="/home/pos/src"
cd $SOURCE_FOLDER && tar -xf *.tar.gz
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install apache2 mysql-server -y
sudo usermod -aG www-data pos
sudo apt-get -y update
sudo add-apt-repository ppa:ondrej/php
sudo apt-get -y update
sudo apt-get install -y php7.1 libapache2-mod-php7.1 php7.1-common php7.1-gd php7.1-mysql php7.1-curl php7.1-intl php7.1-xsl php7.1-mbstring php7.1-zip php7.1-bcmath php7.1-iconv php7.1-soap
sudo mysql -u root -p -e "create user 'pos'@'localhost' identified by 'pos'"
sudo mysql -u root -p -e "grant all privileges on *.* to 'pos'@'localhost' identified by 'pos'"
mysql -u pos -ppos -e "create database pos"
cd $SOURCE_FOLDER &&  sudo find app generated var vendor pub -type f -exec chmod g+w {} \; && sudo find app generated var             vendor pub -type d -exec chmod g+ws {} \; && sudo chown -R :www-data . && sudo chmod                                 u+x  bin/magento
