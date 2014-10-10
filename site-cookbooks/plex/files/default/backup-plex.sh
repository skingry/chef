#!/bin/bash

PLEXHOME="/var/lib/plexmediaserver"
DATE=`date +%Y%m%d%H%M`
BACKUP_DIR="/shared/Backups/applications/plex"

cd ${BACKUP_DIR}

tar -cf - "${PLEXHOME}/Library/Application Support/Plex Media Server/" | gzip -c > plex-${DATE}.tgz

find ./ -mtime +30 -exec rm {} \;

