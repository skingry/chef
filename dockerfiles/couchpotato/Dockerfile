FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Update my package repos
RUN apt-get -q update

# Install prerequisites
RUN apt-get install -y python-cheetah python-lxml python-openssl

# Clone the code repo
RUN git clone https://github.com/CouchPotato/CouchPotatoServer.git /couchpotato

# Install the startup script
COPY files/couchpotato /sbin/couchpotato
RUN chmod 755 /sbin/couchpotato

# Start CouchPotato
CMD ["/sbin/couchpotato"]
