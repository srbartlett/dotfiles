#!/bin/bash

host=$(hostname)
log="/tmp/backup.log"
src=$HOME
dest=/Volumes/Station

echo "++ START BACKUP $(date)" > $log
echo "" >> $log
echo "host: $(hostname -f)" >> $log
echo "" >> $log

rsync -a -R -r --stats --progress --delete --files-from=/Users/stephen/backup_list --exclude-from=/Users/stephen/backup_exclude /Users/stephen/ $dest/$host/ >> $log

echo "" >> $log
echo "-- END BACKUP $(date)" >> $log
