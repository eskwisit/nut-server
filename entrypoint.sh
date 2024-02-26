#!/bin/bash
set -e

CRON_CMD='wget --spider --user guest --password guest'
HOSTED_API=http://127.0.0.1:9000/api
CRON_FOLDER=/etc/cron.d

echo 'Registering cron task'

rm -f $CRON_FOLDER/polling-titles && touch $CRON_FOLDER/polling-titles

echo "0 1 * * * $CRON_CMD $HOSTED_API/scan" >>$CRON_FOLDER/polling-titles

chmod 0644 $CRON_FOLDER/polling-titles

crontab $CRON_FOLDER/polling-titles

service cron start

echo 'Starting nut server on port 9000'

python3 /root/nut/nut.py --server
