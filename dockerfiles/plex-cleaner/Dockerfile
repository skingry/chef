FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Update my package repos
RUN apt-get -q update

# Clone the code repo
RUN git clone https://github.com/ngovil21/Plex-Cleaner.git /plex-cleaner

# Install the startup script
COPY files/plex-cleaner /sbin/plex-cleaner
RUN chmod 755 /sbin/plex-cleaner

# Start Plex Cleaner
CMD ["/sbin/plex-cleaner"]
