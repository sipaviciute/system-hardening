#!/bin/bash

sudo apt update

sudo apt install curl gnupg2 ca-certificates lsb-release build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev -y

cd /usr/local/src
sudo wget https://nginx.org/download/nginx-1.20.2.tar.gz
sudo tar -xzf nginx-1.20.2.tar.gz
cd nginx-1.20.2

sudo ./configure --prefix=/etc/nginx
sudo make
sudo make install

sudo tee /etc/systemd/system/nginx.service << EOF
[Unit]
Description=The NGINX HTTP and reverse proxy server
After=syslog.target network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
PIDFile=/etc/nginx/logs/nginx.pid
ExecStartPre=/etc/nginx/sbin/nginx -t
ExecStart=/etc/nginx/sbin/nginx
ExecReload=/etc/nginx/sbin/nginx -s reload
ExecStop=/bin/kill -s QUIT \$MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable nginx
sudo systemctl start nginx

sudo mkdir -p /etc/nginx/sites-available
sudo mkdir -p /etc/nginx/sites-enabled
sudo tee /etc/nginx/sites-available/main.conf << 'EOF'
#upstream php {
#        server unix:/tmp/php-cgi.socket;
#        server 127.0.0.1:9000;
#}
server {
        server_name domain.tld;
        root /var/www/html;
        
	index index.php;

        location = /favicon.ico {
                log_not_found off;
                access_log off;
        }

        location = /robots.txt {
                allow all;
                log_not_found off;
                access_log off;
        }

        location / {
                # This is cool because no php is touched for static content.
                # include the "?$args" part so non-default permalinks doesn't break when using query string
                try_files $uri $uri/ /index.php?$args;
        }

        location ~ \.php$ {
                include fastcgi_params;
                fastcgi_intercept_errors on;
                fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
                #The following parameter can be also included in fastcgi_params file
                fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }

        location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
                expires max;
                log_not_found off;
        }
}
EOF

sudo ln -s /etc/nginx/sites-available/main.conf /etc/nginx/sites-enabled/
sudo systemctl restart nginx

sudo mkdir -p /etc/nginx/conf/snippets

sudo tee /etc/nginx/conf/snippets/fastcgi-php.conf << 'EOF'
# regex to split $uri to $fastcgi_script_name and $fastcgi_path
fastcgi_split_path_info ^(.+\.php)(/.+)$;

# Check that the PHP script exists before passing it
try_files $fastcgi_script_name =404;

# Bypass the fact that try_files resets $fastcgi_path_info
# see: http://trac.nginx.org/nginx/ticket/321
set $path_info $fastcgi_path_info;
fastcgi_param PATH_INFO $path_info;

fastcgi_index index.php;
include fastcgi.conf;
EOF


sudo tee /etc/nginx/conf/nginx.conf<< 'EOF'
user  www-data;
worker_processes  1;
#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;

events {
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;
    include /etc/nginx/sites-enabled/*.conf;

    sendfile        on;
    keepalive_timeout  65;

    server {
        listen       80;
        root /var/www/html;
        index  index.php index.html index.htm;
        server_name  localhost;

        client_max_body_size 500M;

        location / { 
            try_files $uri $uri/ /index.php?$args;
        }

        location = /favicon.ico {
            log_not_found off;
            access_log off;
        }

        location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
            expires max;
            log_not_found off;
        }

        location = /robots.txt {
            allow all;
            log_not_found off;
            access_log off;
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   /var/www/html;
        }

        location ~ \.php$ {
            include snippets/fastcgi-php.conf;
            fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            include        fastcgi_params;
        }
    }
}
EOF

sudo systemctl restart nginx