FROM ubuntu:18.04
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Update my package repos
RUN apt-get -q update

# Install base packages
RUN apt-get install -y curl dialog git python python-pip ruby ruby-dev wget

# Install user changing utility
COPY files/setuser /sbin
RUN chmod 755 /sbin/setuser
