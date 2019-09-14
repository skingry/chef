FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Update my package repos
RUN apt-get -q update

# Install prerequisites
RUN apt-get install -y python-cheetah python-lxml python-openssl

# Clone the code repo
RUN git clone https://github.com/drzoidberg33/plexpy.git /plexpy

# Install the startup script
COPY files/plexpy /sbin/plexpy
RUN chmod 755 /sbin/plexpy

# Start PlexPy
CMD ["/sbin/plexpy"]
