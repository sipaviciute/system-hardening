#!/bin/bash

sudo apt update

sudo mkdir -p /var/www/html
cd /usr/local/src
sudo wget https://wordpress.org/wordpress-5.5.3.tar.gz
sudo tar -xzf wordpress-5.5.3.tar.gz
sudo mv wordpress/* /var/www/html

cd /var/www/html
sudo cp wp-config-sample.php wp-config.php
sudo rm index.html

sudo chown -R www-data:www-data /var/www/html
sudo find /var/www/html -type d -exec chmod 755 {} \;
sudo find /var/www/html -type f -exec chmod 644 {} \;
sudo chmod 600 /var/www/html/wp-config.php

cd /var/www/html/wp-content/plugins
sudo wget https://downloads.wordpress.org/plugin/interact-quiz-embed.3.0.7.zip
sudo wget https://downloads.wordpress.org/plugin/iframe.4.6.zip
sudo wget https://downloads.wordpress.org/plugin/blog-filter.1.5.3.zip
sudo wget https://downloads.wordpress.org/plugin/delete-me.3.0.zip
sudo wget https://downloads.wordpress.org/plugin/bellows-accordion-menu.1.4.1.zip
sudo unzip '*.zip'

sudo curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
sudo chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# After the Wordpress setup:
#sudo -u www-data wp plugin activate interact-quiz-embed --path=/var/www/html
#sudo -u www-data wp plugin activate iframe --path=/var/www/html
#sudo -u www-data wp plugin activate blog-filter --path=/var/www/html
#sudo -u www-data wp plugin activate bellows-accordion-menu --path=/var/www/html
#sudo -u www-data wp plugin activate delete-me --path=/var/www/html
