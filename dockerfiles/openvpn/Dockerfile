FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Update my package repos
RUN apt-get -q update

# Install OpenVPN
RUN apt-get -y install openvpn

# Start OpenVPN
CMD ["/usr/sbin/openvpn"]
