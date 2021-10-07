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
yum install -y php php-mysql

echo "############"
echo "Starting PHP"
echo "############"
systemctl restart httpd.service

echo "##################"
echo "Installing Modules"
echo "##################"
yum info php-fpm
yum install -y php-fpm

echo "##################"
echo 'Installing php info'
echo "##################"
cd /var/www/html/
cat > info.php <<- EOF
<?php phpinfo(); ?>
EOF

echo "##################"
echo "Installing MariaDB"
echo "##################"
yum install -y mariadb-server mariadb

echo "################"
echo "Starting MariaDB"
echo "################"
systemctl start mariadb

echo "###################"
echo "Installing Security"
echo "###################"
mysql_secure_installation <<EOF

y
laslaslas10
laslaslas10
y
y
y
y
EOF

echo "####################"
echo "Enable upon start up"
echo "####################"
systemctl enable mariadb

#Credentials
password=laslaslas10

echo "################"
echo "Using mysql tool"
echo "################"
mysqladmin -u root -p$password version

echo "##########################"
echo "Creating Database And User"
echo "##########################"
#ECHO FOR CREATE DATABASE
echo "CREATE DATABASE wordpress; CREATE USER 
wordpressuser@localhost IDENTIFIED by 'laslaslas10'; GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED by 'laslaslas10'; FLUSH PRIVILEGES; "| mysql -u root -p$password

#ECHO FOR CREATE DATABASE


echo "##########################"
echo "Installation of Word Press"
echo "##########################"
yum install -y php-gd

echo "################"
echo "Restarting httpd"
echo "################"
systemctl restart httpd.service

echo "################"
echo "Installing wget"
echo "################"
yum install -y wget

echo "##############"
echo "Installing tar"
echo "##############"
yum install -y tar

echo "#################################"
echo "Installing zip file for wordpress"
echo "#################################"
cd/opt/
wget http://wordpress.org/latest.tar.gz

echo "##############"
echo "Extracting tar"
echo "##############"
tar xzvf latest.tar.gz

echo "################"
echo "Installing Rsync"
echo "################"
yum install -y rsync
rsync -avP wordpress/ /var/www/html/
cd /var/www/html/

echo "###########################################"
echo "Creating directory + Changing the ownership"
echo "###########################################"
mkdir /var/www/html/wp-content/uploads
chown -R apache:apache /var/www/html/*

echo "#####################"
echo "Configuring Wordpress"
echo "#####################"
cp wp-config-sample.php wp-config.php
#vi wp-config.php
cd /var/www/html/
sed -i 's/database_name_here/wordpress/g' wp-config.php
sed -i 's/username_here/wordpressuser/g' wp-config.php
sed -i 's/password_here/laslaslas10/g' wp-config.php

echo "#########################"
echo "Installing latest version"
echo "##########################"
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm

echo "Installing yum utils"
yum install -y yum-utils

echo "Enable remi-php56"
yum-config-manager --enable remi-php56

echo "Php mycrypt"
yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo

echo "Restarting Httpd"
systemctl restart httpd.service

echo "#################################"
echo "#                               #"
echo "#                               #"
echo "#           SUCCESS             #"
echo "#                               #"
echo "#                               #"
echo "#################################"