#!/bin/bash
# go to https://github.com/mars-trueplus/public-resourc
# download magento source and put it to SOURCE_FOLDER

USER="pos"
SOURCE_FOLDER="/home/pos/src"
cd $SOURCE_FOLDER && tar -xf *.tar.gz && sudo chown -R $USER .

# config visudo to run sudo command without password
sudo visudo
# add this line to the end of file (replace pos with value of $USER)
pos ALL=(ALL) NOPASSWD: ALL

sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install apache2 mysql-server -y
sudo usermod -aG www-data $USER
sudo apt-get -y update
sudo add-apt-repository ppa:ondrej/php
sudo apt-get -y update
sudo apt-get install -y php7.1 libapache2-mod-php7.1 php7.1-common php7.1-gd php7.1-mysql php7.1-curl php7.1-intl php7.1-xsl php7.1-mbstring php7.1-zip php7.1-bcmath php7.1-iconv php7.1-soap
sudo mysql -u root -p -e "create user 'pos'@'localhost' identified by 'pos'"
sudo mysql -u root -p -e "grant all privileges on *.* to 'pos'@'localhost' identified by 'pos'"
mysql -u pos -ppos -e "create database pos"
cd $SOURCE_FOLDER &&  sudo find app generated var vendor pub -type f -exec chmod g+w {} \; && sudo find app generated var             vendor pub -type d -exec chmod g+ws {} \; && sudo chown -R :www-data . && sudo chmod                                 u+x  bin/magento

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
./ngrok http 80
# install magento

# get the https link and install mageto
# run some command to magento work correctly with ssl
# if your base url change
# update it
php bin/magento setup:store-config:set --base-url="http://4793b244.ngrok.io/" && php bin/magento setup:store-config:set --use-secure=1 --base-url="https://4793b244.ngrok.io/" && php bin/magento setup:store-config:set --use-secure-admin=1 --base-url="https://4793b244.ngrok.io/" && php bin/magento config:set web/url/redirect_to_base 0 && php bin/magento c:f


