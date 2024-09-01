#!/bin/bash

sudo apt update

sudo mkdir /usr/local/mysql
cd /usr/local/mysql
sudo wget https://cdn.mysql.com/archives/mysql-8.0/mysql-server_8.0.35-1debian11_amd64.deb-bundle.tar
sudo tar -xf mysql-server_8.0.35-1debian11_amd64.deb-bundle.tar
sudo apt update
sudo apt install libmecab2 libnuma1 perl psmisc -y
sudo dpkg -i mysql-common_8.0.35-1debian11_amd64.deb
sudo dpkg -i mysql-community-client-plugins_8.0.35-1debian11_amd64.deb
sudo dpkg -i mysql-community-client-core_8.0.35-1debian11_amd64.deb
sudo dpkg -i mysql-community-client_8.0.35-1debian11_amd64.deb
sudo dpkg -i mysql-client_8.0.35-1debian11_amd64.deb
sudo dpkg -i libmysqlclient21_8.0.35-1debian11_amd64.deb
sudo dpkg -i libmysqlclient-dev_8.0.35-1debian11_amd64.deb
sudo dpkg -i mysql-community-server-core_8.0.35-1debian11_amd64.deb
sudo dpkg -i mysql-community-server_8.0.35-1debian11_amd64.deb
sudo dpkg -i mysql-server_8.0.35-1debian11_amd64.deb
sudo dpkg --configure -a
sudo systemctl enable mysql
sudo systemctl start mysql

mysql --version

sudo sed -i 's/bind-address\s*=\s*127\.0\.0\.1/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

sudo systemctl restart mysql


# CREATE USER 'user1'@'localhost' IDENTIFIED BY '123456';
# CREATE USER 'user2'@'localhost' IDENTIFIED BY 'password';
# CREATE USER 'user3'@'localhost' IDENTIFIED BY 'qwerty';
# CREATE USER 'user4'@'localhost' IDENTIFIED BY 'abc123';
# CREATE USER 'user5'@'localhost' IDENTIFIED BY '123123';
# CREATE USER 'user6'@'localhost' IDENTIFIED BY 'admin';
# CREATE USER 'user7'@'localhost' IDENTIFIED BY '111111';
# CREATE USER 'user8'@'localhost' IDENTIFIED BY '12345678';
# CREATE USER 'user9'@'localhost' IDENTIFIED BY 'iloveyou';
# CREATE USER 'user10'@'localhost' IDENTIFIED BY 'welcome';

# select user, plugin from mysql.user;

# create database wordpress;
# create user 'wp'@'<web_ip>' identified by 'password';
# grant all privileges on wordpress.* to 'wp'@'<web_ip>';
# flush privileges;