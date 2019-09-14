FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Update my package repos
RUN apt-get -q update

# Install awscli
RUN pip install awscli

CMD ["/sbin/backup"]
