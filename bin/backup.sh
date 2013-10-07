#!/bin/bash

host=$(hostname)
log="/tmp/backup.log"
src=$HOME

echo "++ START BACKUP $(date)" > $log
echo "" >> $log
echo "host: $(hostname -f)" >> $log
echo "" >> $log

rsync -a -R --stats --progress --delete --files-from=/Users/stephen/backup_list --exclude-from=/Users/stephen/backup_exclude /Users/stephen/ /Volumes/backup/$host/ >> $log

echo "" >> $log
echo "-- END BACKUP $(date)" >> $log
