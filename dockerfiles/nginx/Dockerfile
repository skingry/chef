FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Update my package repos
RUN apt-get -q update

# Install core components
RUN apt-get install -y nginx

# Install startup script
COPY files/nginx /sbin/nginx
RUN chmod 755 /sbin/nginx

# Start Nginx
CMD ["/sbin/nginx"]
