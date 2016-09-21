FROM skingry/base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Define packages I need to build other things... and the packages I need to run the things
ENV DEPS="build-essential libevent-dev libssl-dev libgcrypt11-dev libkrb5-dev libpam0g-dev libwrap0-dev libdb-dev libtdb-dev libmysqlclient-dev libavahi-client-dev libacl1-dev libldap2-dev libcrack2-dev systemtap-sdt-dev libdbus-1-dev libdbus-glib-1-dev libglib2.0-dev libtracker-sparql-1.0-dev libtracker-miner-1.0-dev file"
ENV DEFAULT="avahi-daemon"
ENV RUNTIME="libevent-2.0 libavahi-client3 libevent-core-2.0 libwrap0 libtdb1 libmysqlclient20 libcrack2 libdbus-glib-1-2 libtracker-sparql-1.0-dev"

# Update my package repos
RUN apt-get -q update

# Install my build dependencies
RUN apt-get install --no-install-recommends --fix-missing --assume-yes $DEPS

# Install my default packages
RUN apt-get install --no-install-recommends --fix-missing --assume-yes $DEFAULT

# Install and run the Chef code
RUN git clone https://github.com/skingry/chef.git
WORKDIR /chef
RUN berks vendor cookbooks && \
    chef-solo -c solo.rb -j configs/netatalk.json

# Remove the build dependencies
RUN apt-get --quiet --yes purge --auto-remove $DEPS

# Install my runtime dependencies
RUN apt-get install --yes $RUNTIME

# Clean Up
RUN apt-get --quiet --yes autoclean && \
    apt-get --quiet --yes autoremove && \
    apt-get --quiet --yes clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* && \
    rm -rf /usr/share/doc /usr/share/man /usr/share/icons /usr/share/poppler /usr/share/mime /usr/share/GeoIP && \
    rm -rf /chef

# Start Netatalk
EXPOSE 548
VOLUME [ "/data" ]
CMD ["/sbin/netatalk"]
