#!/usr/bin/env bash

MAGENTO_VERSION=2.2.6
PHP_VERSION=7.0.33
APACHE_VERSION=
NGINX_VERSION=1.8
MYSQL_VERSION=5.7
MAGENTO_URL=https://secure.php.net/get/php-$PHP_VERSION.tar.gz/from/this/mirror

echo "LC_ALL=en_US.UTF-8" |tee --append /etc/environment

# phpsize dependencies
apt-get update -y && apt-get install -y \
        git \
        build-essential \
        automake \
		autoconf \
		file \
		g++ \
		gcc \
		libc-dev \
		make \
		pkg-config \
		re2c \
		bison \
	--no-install-recommends && rm -r /var/lib/apt/lists/*

# persitent / runtime dependencies
apt-get update -y && apt-get install -y \
		ca-certificates \
		curl \
		libcurl3 \
		libedit2 \
		libsqlite3-0 \
		libxml2 \
	--no-install-recommends && rm -r /var/lib/apt/lists/*
#
apt-get update -y && apt-get install -y apache2-dev \
        libcurl4-openssl-dev \
		libedit-dev \
		libsqlite3-dev \
		libssl-dev \
		libxml2-dev \
		xz-utils \
		wget \
        libpng-dev \
        libjpeg-dev \
        libxpm-dev \
        libfreetype6-dev \
        libxml2-dev \
        libxslt-dev \
	--no-install-recommends && rm -rf /var/lib/apt/lists/*

if [[ $PHP_VERSION == *"7.0"* ]]; then
    # Install PHP 7.0.x
    wget -O php-$PHP_VERSION.tar.gz "$MAGENTO_URL"
    tar -xf php-$PHP_VERSION.tar.gz
    cd php-$PHP_VERSION
    ./configure --enable-fpm \
        --enable-debug \
        --enable-cli \
        --enable-opcache \
        --enable-bcmath \
        --with-curl \
        --with-gd \
        --with-jpeg-dir \
        --with-png-dir \
        --with-zlib-dir \
        --with-xpm-dir \
        --enable-gd-native-ttf \
        --with-freetype-dir \
        --enable-intl \
        --enable-mbstring \
        --with-openssl \
        --enable-pdo \
        --enable-mysqlnd \
        --enable-soap \
        --with-xsl \
        --enable-zip \
        --with-zlib
    make
    make install
    cp php.ini-development /usr/local/php/php.ini
    cp /usr/local/etc/php-fpm.conf.default /usr/local/etc/php-fpm.conf
    cp sapi/fpm/php-fpm /usr/local/bin
    cd .. && rm -rf php-$PHP_VERSION*
fi

# Check a variable is empty or not
if [ -z $NGINX_VERSION ]; then
    echo "1"
    # install nginx
fi

if [ -z $APACHE_VERSION ]; then
    # install apache
    apt-get install apache2 -y
    a2enmod rewrite
    service apache2 restart
fi

if [[ $MYSQL_VERSION == '5.7' ]]; then
    echo "mysql dedeeeee"
fi

#apt install -y mysql-server mysql-client
#mysql_secure_installation
#mysql -u root -p
# Install nginx
#apt-get -y install apache2
#a2enmod rewrite

# Install Mysql 5.6