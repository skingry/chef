#!/bin/bash
# An abomination of a shell script that makes sure the root password on new Percona
# installations is blank... doesn't run if /root/.my.cnf file exists

if [ -e /root/.my.cnf ] ; then
  echo "NO, HUMAN." >&2
  exit 86
fi

echo "-- Resetting password"
echo "DELETE FROM mysql.user WHERE User='';" | mysql
echo "DELETE FROM mysql.user WHERE Host='127.0.0.1';" | mysql
echo "DELETE FROM mysql.user WHERE Host='::1';" | mysql
echo "DELETE FROM mysql.user WHERE User='root' AND Host != 'localhost';" | mysql
echo "DELETE FROM mysql.db;" | mysql
echo "DROP DATABASE test;" | mysql
echo "FLUSH PRIVILEGES;" | mysql

echo "-- Creating /root/.my.cnf file"
touch /root/.my.cnf
chmod 600 /root/.my.cnf
echo "[client]" >> /root/.my.cnf
echo "user=root" >> /root/.my.cnf

