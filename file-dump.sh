#!/bin/sh

# (1) set up all the mysqldump variables
FILE=full.files.`date +"%Y%m%d"`
HOSTNAME=`curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'`.`hostname`
LOGINSSH=youlogin
PASSWORDSSH=youpassword
IPSERVER=youip
# (2) in case you run this more than once a day, remove the previous version of the file
unalias rm     2> /dev/null
rm ${FILE}     2> /dev/null
rm ${FILE}.gz  2> /dev/null

# use this command for a database server on localhost. add other options if need be.
cd /backup/
rsync -avzh /home/ ${FILE}
# (4) gzip the mysql database dump file
tar -czvf $FILE.tar.gz $FILE
rm -rf $FILE
# (5) show the user the result
echo "${FILE}.tar.gz was created:"
ls -l ${FILE}.tar.gz
#find files over 2 days
find /backup -type f -mtime +2 -print0 | xargs -0 rm -f
#send files on backup server
sshpass -p ${PASSWORDSSH} rsync -avz -e "ssh -o StrictHostKeyChecking=no" /backup/ ${LOGINSSH}@${IPSERVER}:/backups/${HOSTNAME}/
