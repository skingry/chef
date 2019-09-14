FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Update my package repos
RUN apt-get -q update

# Install prerequisites
RUN apt-get install -y wget

# Install Resilio
RUN wget https://download-cdn.resilio.com/stable/linux-x64/resilio-sync_x64.tar.gz
RUN tar -xvzf resilio-sync_x64.tar.gz
RUN rm resilio-sync_x64.tar.gz

# Copy the startup script
COPY files/rslsync /sbin/rslsync
RUN chmod 755 /sbin/rslsync

# Start Resilio
CMD ["/sbin/rslsync"]
