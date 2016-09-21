FROM skingry/base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Update my package repos
RUN apt-get -q update

# Install and run the Chef code
RUN git clone https://github.com/skingry/chef.git
WORKDIR /chef
RUN berks vendor cookbooks && \
    chef-solo -c solo.rb -j configs/couchpotato.json

# Clean Up
RUN apt-get --quiet --yes autoclean && \
    apt-get --quiet --yes autoremove && \
    apt-get --quiet --yes clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* && \
    rm -rf /usr/share/doc /usr/share/man && \
    rm -rf /chef /root/.berkshelf

# Start CouchPotato
EXPOSE 5050
VOLUME [ "/data" ]
CMD ["/sbin/couchpotato"]
