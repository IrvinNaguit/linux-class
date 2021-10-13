#!/bin/bash

echo "################################"
echo "Creating Backup for the Database"
echo "################################"
cd /opt/
mkdir backups
mysqldump -u root -p$password wordpress >/opt/backups/wordpress_10-15-21.sql 

echo "######################################"
echo "Checking of the backup database script"
echo "######################################"
cat /opt/backups/wordpress_10-15-21.sql

echo "#########################"
echo "Compression of the backup"
echo "#########################"
cd backups
gzip wordpress_10-15-21.sql

echo "#########################"
echo "Checking of the gzip file"
echo "#########################"
ls -l

echo "#################################"
echo "#                               #"
echo "#                               #"
echo "#        BACKUP SUCCESS         #"
echo "#                               #"
echo "#                               #"
echo "#################################"







