#!/bin/sh
#run install the for backup
mkdir /backup
cp mysql-database-dump.sh /mysql-database-dump.sh
cp file-dump.sh /file-dump.sh
chmod +x /mysql-database-dump.sh
chmod +x /file-dump.sh
chmod +x -R /backup/
echo "0 5 * * * root /mysql-database-dump.sh >/dev/null &" >> /etc/crontab #05:00 am
echo "0 5 * * * root /file-dump.sh >/dev/null &" >> /etc/crontab #05:00 am
echo "Comoleate!"