#!/bin/bash

# Record current date
DATE=`date +%Y%m%d`

# Create backup file
tar -cf - /data/configs | gzip -c > /tmp/configs-backup-${DATE}.tgz

# Send the backup file to S3
aws s3 cp /tmp/configs-backup-${DATE}.tgz s3://s3.robotozon.com/backups/

# Clean up after ourselves
rm /tmp/configs-backup-${DATE}.tgz

