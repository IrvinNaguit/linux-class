#!/bin/bash


echo "################"
echo "Installing HTTPD"
echo "################"
#Installing httpd by using yum install httpd
yum install -y httpd

echo "################"
echo "Starting HTTPD"
echo "################"
#In order for you to start the service we used the systemctl star httpd.service
systemctl start httpd.service

echo "#####################"
echo "Adding Firewall Rules"
echo "#####################"
#Adding firewall by the use of this command helps the server for network security system which filters the traffic by the use of rules.
firewall-cmd --add-port 80/tcp --permanent
firewall-cmd --reload
firewall-cmd --permanent --add-port 443/tcp
firewall-cmd --reload

echo "####################"
echo "Enable upon start up"
echo "####################"
#In order for you to no repeat the systemctl start httpd.service when you open the virtual box, using the enable httpd.service it automatically ups the server.
systemctl enable httpd.service

echo "#################################"
echo "#                               #"
echo "#                               #"
echo "#        PART 1 SUCCESS         #"
echo "#                               #"
echo "#                               #"
echo "#################################"



echo "##############"
echo "Installing PHP"
echo "##############"
#Using the yum command we will install the php.
yum install -y php php-mysql

echo "############"
echo "Starting PHP"
echo "############"
#Restarting the service is for service to take effect.
systemctl restart httpd.service

echo "##################"
echo "Installing Modules"
echo "##################"
#This part of the script installs the modules which contains the info php-fpm by the use of yum command to install it.
yum info php-fpm
yum install -y php-fpm

echo "##################"
echo 'Installing php info'
echo "##################"
#In installing php info we used the command cat and EOF for the automation. On which we changeg the directory to var/www/html
#and using the cat to concat info.php automating the <?php phpinfo(): ?> text inside the info.php
cd /var/www/html/
cat > info.php <<- PHPINSTALL
<?php phpinfo(); ?>
PHPINSTALL


echo "#################################"
echo "#                               #"
echo "#                               #"
echo "#         PART 2 SUCCESS        #"
echo "#                               #"
echo "#                               #"
echo "#################################"


echo "##################"
echo "Installing MariaDB"
echo "##################"
#Installation of the mariadb server to have the priveleges in creating database and so on and so forth.
yum install -y mariadb-server mariadb

echo "################"
echo "Starting MariaDB"
echo "################"
#This is to start the mariadb service.
systemctl start mariadb

echo "###################"
echo "Installing Security"
echo "###################"
#The use EOF command is <<EOF means that we will going to enter a multiline string up to the end tag which is the EOF
#Inside the EOF we had automated the yes answer for the questions that was being given to the user and the password for the sql secure. 
mysql_secure_installation <<SecureInstallation

y
laslaslas10
laslaslas10
y
y
y
y
SecureInstallation

echo "####################"
echo "Enable upon start up"
echo "####################"
#In order for the user to no longer up the service, we used the systemctl enable mariadb for us to up the server.
systemctl enable mariadb

#Credentials
password=laslaslas10

echo "################"
echo "Using mysql tool"
echo "################"
#This command helps us to enter the sql syntax by the use of the variable that we have declared which is password.
mysqladmin -u root -p$password version

echo "##########################"
echo "Creating Database And User"
echo "##########################"
#This part of the script in order for us to automate the commands we echoed each of the sql commands in creating database, creating a user
#giving privileges on the user identifying by the use of the password of the sql, and using flush command in order for us to refresh the commands
#that we have entered. 
echo "CREATE DATABASE wordpress; CREATE USER 
wordpressuser@localhost IDENTIFIED by 'laslaslas10'; GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED by 'laslaslas10'; FLUSH PRIVILEGES; "| mysql -u root -p$password



echo "#################################"
echo "#                               #"
echo "#                               #"
echo "#         PART 3 SUCCESS        #"
echo "#                               #"
echo "#                               #"
echo "#################################"


echo "##########################"
echo "Installation of Word Press"
echo "##########################"
#This is the installation of the wordpress for us to create a wordpress.
yum install -y php-gd

echo "################"
echo "Restarting httpd"
echo "################"
#Restarting the service in order for the command to take effect.
systemctl restart httpd.service

echo "################"
echo "Installing wget"
echo "################"
#Using the wget in order for us to download the zip file for the wordpress.
yum install -y wget

echo "##############"
echo "Installing tar"
echo "##############"
#We will use the tar command for us to extract the downloaded file.
yum install -y tar

echo "#################################"
echo "Installing zip file for wordpress"
echo "#################################"
#In this part of the script we entered the /opt/ then we copied the link for the wordpress in order for us to download the file.
#After downloading the wordpress link we will extract it by using tar.
cd/opt/
wget http://wordpress.org/latest.tar.gz

echo "##############"
echo "Extracting tar"
echo "##############"
tar xzvf latest.tar.gz

echo "################"
echo "Installing Rsync"
echo "################"
#We've installed rsync for us to sync files which we have executed in this line.
yum install -y rsync
rsync -avP wordpress/ /var/www/html/
cd /var/www/html/

echo "###########################################"
echo "Creating directory + Changing the ownership"
echo "###########################################"
#We've created a directory uploads for the configuring of the wordpress by the use of mkdir command
#And we also changed the ownership of the /var/www/html to apache:apache using chown command.
mkdir /var/www/html/wp-content/uploads
chown -R apache:apache /var/www/html/*

echo "#####################"
echo "Configuring Wordpress"
echo "#####################"
#In configuring Wordpress, we will copy the wp-config-sample.php as is and rename it to wp-config
#Going inside var/www/html we will use the command sed on which by using this command it will help us
#Change the database name,username, and password inside wp-config.php. So in simple terms we used sed
#For us to do text manipulations inside the file.
cp wp-config-sample.php wp-config.php
cd /var/www/html/
sed -i 's/database_name_here/wordpress/g' wp-config.php
sed -i 's/username_here/wordpressuser/g' wp-config.php
sed -i 's/password_here/laslaslas10/g' wp-config.php

echo "#########################"
echo "Installing latest version"
echo "##########################"
#In the normal script we cannot successfully install the wordpress because it has the older version, so in this part
#of the script we had installed the latest version on which it will help the script run the latest version in order for us
#to install the wordpress.
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
echo "#####################"
echo "Installing yum utils "
echo "#####################"
#The use of installing yum utils helps us manage other repositories which means it is a collection of programs and aids for packges.
yum install -y yum-utils
echo "##################"
echo "Enable remi-php56"
echo "#################"
#We installed remi-php56 which contains PHP scripts.
yum-config-manager --enable remi-php56
echo "###########"
echo "Php mycrypt"
echo "###########"
#Php mycrypt is an extension interface to the mcrypt cryptography library and also it supports a wide variety of algorithms.
yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
echo "################"
echo "Restarting Httpd"
echo "################"
#Restarting the service in order for the command to take effect.
systemctl restart httpd.service

echo "#################################"
echo "#                               #"
echo "#                               #"
echo "#        PART 4 SUCCESS         #"
echo "#                               #"
echo "#                               #"
echo "#################################"


echo "You may now enter you IP ADDRESS in any browser"
