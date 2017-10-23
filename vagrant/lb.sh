#!/bin/bash
echo 'PROVISION LB'
sudo yum -y install epel-release
sudo yum -y install nginx 
rm -rf /etc/nginx/nginx.conf
echo "
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;
include /usr/share/nginx/modules/*.conf;
events {
    worker_connections 1024;
}
http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
    access_log  /var/log/nginx/access.log  main;
    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;
    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;
    include /etc/nginx/conf.d/*.conf;
	upstream backend {
   server 10.0.0.11:8080 weight=1;
   server 10.0.0.12:8080 weight=1;
	}
	server {
        listen       80;
        server_name  10.0.0.10;
        location / {
           proxy_pass http://backend;
           proxy_intercept_errors on;
}}
}" >> /etc/nginx/nginx.conf
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
yum -y install unzip
yum -y install avahi avahi-autoipd avahi-compat-libdns_sd avahi-glib avahi-gobject avahi-tools nss-mdns nss-mdns.i?86
systemctl start avahi-daemon
wget https://releases.hashicorp.com/serf/0.8.1/serf_0.8.1_linux_amd64.zip
unzip serf_0.8.1_linux_amd64.zip -d /usr/local/bin
/usr/local/bin/serf agent -node=**NginxNode1** -bind=10.0.0.10 &>/dev/null &disown
#bg











