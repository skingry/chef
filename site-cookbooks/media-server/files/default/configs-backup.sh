#!/bin/bash

# Record current date
DATE=`date +%Y%m%d`

# Get the hostname of the server
HOSTNAME=`hostname -f`

BACKUP_FILE="${HOSTNAME}configs-backup-${DATE}.tgz"

# Create backup file
tar -cf - /data/configs | gzip -c > /tmp/${BACKUP_FILE}

# Send the backup file to S3
aws s3 cp /tmp/${BACKUP_FILE} s3://s3.robotozon.com/backups/

# Clean up after ourselves
rm /tmp/${BACKUP_FILE}

