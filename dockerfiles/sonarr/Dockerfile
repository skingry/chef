FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Install the Sonarr apt repo
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC
RUN echo "deb http://apt.sonarr.tv/ master main" | tee /etc/apt/sources.list.d/sonarr.list

# Update my package repos
RUN apt-get -q update

# Install Sonarr
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libmono-cil-dev nzbdrone

# Install the startup script
COPY files/sonarr /sbin/sonarr
RUN chmod 755 /sbin/sonarr

# Start Sonarr
CMD ["/sbin/sonarr"]
