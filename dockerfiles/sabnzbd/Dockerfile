FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Set the locale info to use UTF-8
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Update my package repos
RUN apt-get -q update

# Install prerequisites
RUN apt-get install -y python-cheetah python-lxml python-openssl
RUN apt-get install -y p7zip-full par2 python-yenc unzip
RUN wget -O /tmp/unrar.deb http://launchpadlibrarian.net/214085480/unrar_5.3.2-1_amd64.deb
RUN dpkg -i /tmp/unrar.deb

# Clone the code repo
RUN git clone https://github.com/sabnzbd/sabnzbd.git /sabnzbd

# Install the startup script
COPY files/sabnzbd /sbin/sabnzbd
RUN chmod 755 /sbin/sabnzbd

# Start SABnzbd
CMD ["/sbin/sabnzbd"]
