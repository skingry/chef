FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

RUN echo "Netatalk"

# Update my package repos
RUN apt-get -q update

# Install the prerequisites
RUN apt-get install -y build-essential libevent-dev libssl-dev libgcrypt11-dev libkrb5-dev \
    libpam0g-dev libwrap0-dev libdb-dev libtdb-dev libmysqlclient-dev libavahi-client-dev \
    libacl1-dev libldap2-dev libcrack2-dev systemtap-sdt-dev libdbus-1-dev libdbus-glib-1-dev \
    libglib2.0-dev libtracker-sparql-1.0-dev libtracker-miner-1.0-dev file avahi-daemon \
    libevent-2.0 libavahi-client3 libevent-core-2.0 libwrap0 libtdb1 libmysqlclient20 \
    libcrack2 libdbus-glib-1-2 libtracker-sparql-1.0-dev

# Grab the Netatalk source code
RUN wget -O /tmp/netatalk.tar.gz 'http://downloads.sourceforge.net/project/netatalk/netatalk/3.1.8/netatalk-3.1.8.tar.gz'

# Extract, configure, and install Netatalk
RUN cd /tmp && tar -xvzf netatalk.tar.gz
RUN cd /tmp/netatalk-3.1.8 && ./configure \
    --prefix='/usr' \
    --sysconfdir='/config' \
    --with-init-style=debian-systemd \
    --without-libevent \
    --without-tdb \
    --with-cracklib \
    --enable-krbV-uam \
    --with-pam-confdir=/etc/pam.d \
    --with-dbus-sysconf-dir=/etc/dbus-1/system.d \
    --with-tracker-pkgconfig-version=1.0 && \
    make && make install

# Install the startup script
COPY files/netatalk /sbin/netatalk
RUN chmod 755 /sbin/netatalk

# Start Netatalk
CMD ["/sbin/netatalk"]
