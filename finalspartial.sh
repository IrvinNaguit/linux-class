#!/bin/bash


echo "################"
echo "Installing HTTPD"
echo "################"
yum install -y httpd

echo "################"
echo "Starting HTTPD"
echo "################"
systemctl start httpd.service

echo "#####################"
echo "Adding Firewall Rules"
echo "#####################"
firewall-cmd --add-port 80/tcp --permanent
firewall-cmd --reload

echo "####################"
echo "Enable upon start up"
echo "####################"
systemctl enable httpd.service

echo "##############"
echo "Installing PHP"
echo "##############"
yum install php php-mysql

echo "############"
echo "Starting PHP"
echo "############"
systemctl restart httpd.service

echo "##################"
echo "Installing Modules"
echo "##################"
yum info php-fpm
yum install php-fpm

echo "##################"
echo "Installing MariaDB"
echo "##################"
yum install mariadb-server mariadb

echo "################"
echo "Starting MariaDB"
echo "################"
systemctl start mariadb

echo "###################"
echo "Installing Security"
echo "###################"
mysql_secure_installation

echo "####################"
echo "Enable upon start up"
echo "####################"
systemctl enable mariadb

echo "################"
echo "Using mysql tool"
echo "################"
mysqladmin -u root -p version

echo "####################"
echo "Enter mysql database"
echo "####################"
mysql -u root -p

echo "##########################"
echo "Installation of Word Press"
echo "##########################"
yum install php-gd

echo "################"
echo "Restarting httpd"
echo "################"
systemctl restart httpd.service

echo "################"
echo "Installing wget"
echo "################"
yum install wget

echo "##############"
echo "Installing tar"
echo "##############"
yum install tar

echo "#############################"
echo "Installing zip file wordpress"
echo "#############################"
cd/opt/
wget http://wordpress.org/latest.tar.gz

echo "##############"
echo "Extracting tar"
echo "##############"
tar xzvf latest.tar.gz

echo "################"
echo "Installing Rsync"
echo "################"
yum install rsync
rsync -avP wordpress/ /var/www/html/
cd /var/www/html/

echo "################"
echo "Creating directory"
echo "################"
mkdir /var/www/html/wp-content/uploads
chown -R apache:apache /var/www/html/*

echo "#####################"
echo "Configuring Wordpress"
echo "#####################"
cp wp-config-sample.php wp-config.php
vi wp-config.php


echo "#########################"
echo "Installing latest version"
echo "##########################"
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm

echo "Installing yum utils"
yum install yum-utils

echo "Enable remi-php56"
yum-config-manager --enable remi-php56

echo "Php mycrypt"
yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo

echo "Restarting Httpd"
systemctl restart httpd.service



