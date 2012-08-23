#!/bin/bash

host=$(hostname)
log="/tmp/backup.log"
src=$HOME

echo "++ START BACKUP $(date)" > $log
echo "" >> $log
echo "host: $(hostname -f)" >> $log
echo "" >> $log

rsync -a --stats --progress --delete --include-from=$HOME/.rsync_includes.txt /Users/stephen/ /Volumes/backup/$host/ >> $log

echo "" >> $log
echo "-- END BACKUP $(date)" >> $log
