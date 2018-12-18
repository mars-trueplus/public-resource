#!/usr/bin/env bash

MAGENTO_VERSION=2.2.6
PHP_VERSION=7.0.33
APACHE_VERSION=
NGINX_VERSION=1.8
MAGENTO_URL=https://secure.php.net/get/php-$PHP_VERSION.tar.gz/from/this/mirror

echo "LC_ALL=en_US.UTF-8" |tee --append env.txt
apt-get -y install git build-essential autoconf automake re2c bison libxml2-dev

if [[ $PHP_VERSION == *"7.0"* ]]; then
    # Install PHP 7.0
    wget -O php-$PHP_VERSION.tar.gz "$MAGENTO_URL"
    tar -xf php-$PHP_VERSION.tar.gz
    cd php-$PHP_VERSION
    ./configure --enable-fpm --enable-debug --enable-cli
    make
    make install
    cp php.ini-development /usr/local/php/php.ini
    cp /usr/local/etc/php-fpm.conf.default /usr/local/etc/php-fpm.conf
    cp sapi/fpm/php-fpm /usr/local/bin
    cd .. && rm -rf php-$PHP_VERSION*
fi

# Check a variable is empty or not
if [ -z $NGINX_VERSION ]; then
    echo "CHA CO DU LIEU J DE SHOW RA CA"
fi


# Install nginx
#apt-get -y install apache2
#a2enmod rewrite

# Install Mysql 5.6