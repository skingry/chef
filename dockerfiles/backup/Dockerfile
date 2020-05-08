FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Update my package repos
RUN apt-get -q update

# Install awscli
RUN pip3 install awscli

CMD ["/sbin/backup"]
