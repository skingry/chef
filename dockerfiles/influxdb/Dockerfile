FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Update my package repos
RUN apt-get -q update

# Install InfluxDb
RUN wget -O /tmp/influxdb.deb https://dl.influxdata.com/influxdb/releases/influxdb_1.4.3_amd64.deb
RUN dpkg -i /tmp/influxdb.deb

# Install the startup script
COPY files/influxdb /sbin/influxdb
RUN chmod 755 /sbin/influxdb

# Start InfluxDb
CMD ["/sbin/influxdb"]
