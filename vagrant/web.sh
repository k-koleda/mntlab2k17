#!/bin/bash

echo 'PROVISION WEB'
cd /usr/share/

yum -y install tomcat
yum -y install unzip
yum -y install tomcat-admin-webapps.noarch tomcat-docs-webapp.noarch tomcat-javadoc.noarch tomcat-systemv.noarch tomcat-webapps.noarch
cp /vagrant/clusterjsp.war /var/lib/tomcat/webapps/
systemctl start tomcat
yum -y install avahi avahi-autoipd avahi-compat-libdns_sd avahi-glib avahi-gobject avahi-tools nss-mdns nss-mdns.i?86
systemctl start avahi-daemon
wget https://releases.hashicorp.com/serf/0.8.1/serf_0.8.1_linux_amd64.zip
unzip serf_0.8.1_linux_amd64.zip -d /usr/local/bin



