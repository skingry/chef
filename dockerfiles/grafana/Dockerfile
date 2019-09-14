FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Update my package repos
RUN apt-get -q update

# Install prerequisites
RUN apt-get install -y libfontconfig ca-certificates

# Install Grafana
RUN wget -O /tmp/grafana.deb https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_4.6.3_amd64.deb
RUN dpkg -i /tmp/grafana.deb

# Install the startup script
COPY files/grafana /sbin/grafana
RUN chmod 755 /sbin/grafana

# Start Grafana
CMD ["/sbin/grafana"]
