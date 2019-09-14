FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Update my package repos
RUN apt-get -q update

# Install nzbget
RUN cd /opt && \
    wget https://nzbget.net/download/nzbget-latest-bin-linux.run && \
    sh nzbget-latest-bin-linux.run --destdir /opt/nzbget && \
    rm nzbget-latest-bin-linux.run
RUN chown -R nobody:nogroup /opt

# Install the startup script
COPY files/nzbget /sbin/nzbget
RUN chmod 755 /sbin/nzbget

# Start nzbget
CMD ["/sbin/nzbget"]
