FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

RUN echo "Samba"

# Update my package repos
RUN apt-get -q update

# Install the prerequisites
RUN apt-get -y install \
    acl attr autoconf bind9utils bison build-essential \
    debhelper dnsutils docbook-xml docbook-xsl flex gdb libjansson-dev \
    libacl1-dev libaio-dev libarchive-dev libattr1-dev libblkid-dev libbsd-dev \
    libcap-dev libcups2-dev libgnutls28-dev libjson-perl \
    libldap2-dev libncurses5-dev libpam0g-dev libparse-yapp-perl \
    libpopt-dev libreadline-dev nettle-dev perl perl-modules pkg-config \
    python-all-dev python-crypto python-dbg python-dev python-dnspython \
    python3-dnspython python-markdown python3-markdown \
    python3-dev xsltproc zlib1g-dev

# Install Samba
RUN wget https://download.samba.org/pub/samba/stable/samba-4.8.0.tar.gz && \
    tar -xzf samba-4.8.0.tar.gz && \
    cd samba-4.8.0 && \
    ./configure --sysconfdir=/etc --prefix=/usr --enable-fhs && \
    make && \
    make install && \
    rm -rf /samba-4.8.0

# Install the startup script
COPY files/samba /sbin/samba
RUN chmod 755 /sbin/samba

# Start Samba
CMD ["/sbin/samba"]
