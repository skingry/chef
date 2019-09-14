FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Update my package repos
RUN apt-get -q update

# Clone the code repo
RUN git clone https://github.com/certbot/certbot.git /certbot

# Install the startup script
COPY files/certbot /sbin/certbot
RUN chmod 755 /sbin/certbot

# Start Certbot
CMD ["/sbin/certbot"]
