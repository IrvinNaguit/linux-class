#!/bin/bash

echo "################################"
echo "Creating Backup for the Database"
echo "################################"
#In creating backup for database you will be using mysqldump, mysqldump is a command-line utility which can generate the logical backup of the MYSQL DATABASE.
#The name for the backupfilename is wordpress_10-15-21.sql
cd /opt/
mkdir backups
mysqldump -u root -p$password wordpress >/opt/backups/wordpress_10-15-21.sql 

echo "######################################"
echo "Checking of the backup database script"
echo "######################################"
#This command will cat the file wordpress backup
cat /opt/backups/wordpress_10-15-21.sql

echo "#########################"
echo "Compression of the backup"
echo "#########################"
#Using gzip you can compress the backupfile.
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







