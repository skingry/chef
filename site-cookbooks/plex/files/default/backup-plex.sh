#!/bin/bash

PLEXHOME="/var/lib/plexmediaserver"
DATE=`date +%Y%m%d%H%M`

tar -cvf - "${PLEXHOME}/Library/Application Support/Plex Media Server/" | gzip -c > plex-${DATE}.tgz
