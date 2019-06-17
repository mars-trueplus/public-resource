#!/bin/bash
# execute this file with normal user
# go to https://github.com/mars-trueplus/public-resource
# download magento source, put it to SOURCE_FOLDER and extract it
# cd $SOURCE_FOLDER && tar -xf *.tar.gz
USER="ubuntu"
SOURCE_FOLDER="/home/ubuntu/magento/src"


# config visudo to run sudo command without password
# $ sudo visudo

# add this line to the end of file (replace pos with value of $USER)
# pos ALL=(ALL) NOPASSWD: ALL

sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install apache2 mysql-server -y
sudo usermod -aG www-data $USER
sudo apt-get -y update
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get -y update
sudo apt-get install -y php7.1 libapache2-mod-php7.1 php7.1-common php7.1-gd php7.1-mysql php7.1-mcrypt php7.1-curl php7.1-intl php7.1-xsl php7.1-mbstring php7.1-zip php7.1-bcmath php7.1-iconv php7.1-soap

sudo apt-get update && sudo apt-get install software-properties-common -y && sudo add-apt-repository universe -y && sudo add-apt-repository ppa:certbot/certbot -y && sudo apt-get update && sudo apt-get install certbot python-certbot-apache -y

sudo mysql -u root -p -e "create user 'pos'@'localhost' identified by 'pos'"
sudo mysql -u root -p -e "grant all privileges on *.* to 'pos'@'localhost' identified by 'pos'"
mysql -u pos -ppos -e "create database pos"
cd $SOURCE_FOLDER && sudo find app generated var vendor pub -type f -exec chmod g+w {} \; && sudo find app generated var vendor pub -type d -exec chmod g+ws {} \; && sudo chown -R :www-data . && sudo chmod u+x  bin/magento

# update apache config to source folder
#
# DocumentRoot /home/pos/src
# <Directory /home/pos/src>
#   Options FollowSymLinks MultiViews
#   AllowOverride All
#   Order deny,allow
#   Require all granted
# </Directory>


# go to https://github.com/mars-trueplus/public-resourc
# download ngork and extract it to SOURCE_FOLDER
# run ngork to get a domain with ssl
# $ ./ngrok http 80

# install magento

# after install magento
# $ sudo a2enmod rewrite
