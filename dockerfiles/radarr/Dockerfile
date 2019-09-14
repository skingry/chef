FROM base
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

RUN \
 echo "**** install apt-transport-https ****" && \
 apt-get update && \
 apt-get install -y apt-transport-https && \
 echo "**** add mono repository ****" && \
 apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
 echo "deb http://download.mono-project.com/repo/ubuntu xenial main" | tee /etc/apt/sources.list.d/mono-official.list && \
 echo "**** add mediaarea repository ****" && \
 apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5CDF62C7AE05CC847657390C10E11090EC0E438 && \
 echo "deb https://mediaarea.net/repo/deb/ubuntu xenial main" | tee /etc/apt/sources.list.d/mediaarea.list && \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y \
	--no-install-recommends \
	--no-install-suggests \
	bzip2 \
  curl \
	ca-certificates-mono \
	libcurl4-openssl-dev \
	mediainfo \
	mono-devel \
	mono-vbnc \
	python \
	sqlite3 \
	unzip && \
 echo "**** clean up ****" && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# Install Radarr
RUN cd /opt && \
    wget $(curl -s https://api.github.com/repos/Radarr/Radarr/releases | grep linux.tar.gz | grep browser_download_url | head -1 | awk '{print $2}'  | awk -F\" '{print $2}') && \
    tar -xvzf Radarr.develop.*.linux.tar.gz
RUN chown -R nobody:nogroup /opt

# Install the startup script
COPY files/radarr /sbin/radarr
RUN chmod 755 /sbin/radarr

# Start Radarr
CMD ["/sbin/radarr"]
