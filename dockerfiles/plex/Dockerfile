FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Update my package repos and install udev
RUN apt-get update
RUN apt-get install -y udev libva-dev

# Install defaults file
RUN mkdir /defaults
COPY files/defaults /defaults/plexmediaserver

# Install Plex Server
RUN wget -O /tmp/plexmediaserver.deb 'https://plex.tv/downloads/latest/1?channel=8&build=linux-ubuntu-x86_64&distro=ubuntu'
RUN dpkg -i /tmp/plexmediaserver.deb && rm -rf /tmp/plexmediaserver.deb

# Install scripts
COPY files/update_plex /sbin/update_plex
COPY files/start_pms /usr/sbin/start_pms
COPY files/plex /sbin/plex
RUN chmod 755 /sbin/update_plex /sbin/plex /usr/sbin/start_pms

# Start Plex
CMD ["/sbin/plex"]
