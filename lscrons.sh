#!/bin/sh
#
# lscron  show task in crontab of all users
#

if [ `id -u` != 0 ]; then
    echo 'permission denied. only root can run';
    exit 1;
fi

# configuration
_CRONTABS=/var/spool/cron

for cronfile in $(ls ${_CRONTABS});
do

echo '------------------------------------------------------------'
echo 'USER:'${cronfile}
echo '------------------------------------------------------------'
cat ${_CRONTABS}/${cronfile}; 
echo ''

done;
