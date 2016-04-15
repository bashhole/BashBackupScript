#!/bin/sh
#On server backups run
#auto insert
mkdir /backups/
chmod +x /backups/
echo "0 5 * * * root find /backups/ -type f -mtime +15 -print0 | xargs -0 rm -f" >> /etc/crontab
# delete old archive over 15 days = mtime +15