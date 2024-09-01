#!/bin/bash

sudo apt update

sudo apt install default-mysql-client -y

sudo apt install apt-transport-https lsb-release ca-certificates -y

sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
sudo sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'

sudo apt update

sudo apt install php7.4 php7.4-fpm php7.4-mysql php7.4-xml php7.4-mbstring php7.4-gd php7.4-curl php7.4-zip php7.4-common php7.4-cli -y

php_ini="/etc/php/7.4/cli/php.ini"

if [ -f "$php_ini" ]; then
    sudo sed -i 's/;cgi\.fix_pathinfo=1/cgi\.fix_pathinfo=0/' $php_ini
else
    echo "Error: $php_ini does not exist."
fi

www_conf="/etc/php/7.4/fpm/pool.d/www.conf"

if [ -f "$www_conf" ]; then
    sudo sed -i 's/;listen\.mode = 0660/listen.mode = 0660/' $www_conf
else
    echo "Error: $www_conf does not exist."
fi
