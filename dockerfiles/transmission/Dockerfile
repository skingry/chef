FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Update my package repos
RUN apt-get -q update

# Install the Transmission apt repo
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:transmissionbt/ppa

# Update the package repos again
RUN apt-get -q update

# Install Transmission
RUN apt-get install -y transmission-cli transmission-common

# Install the startup script
COPY files/transmission /sbin/transmission
RUN chmod 755 /sbin/transmission

# Start Transmission
CMD ["/sbin/transmission"]
