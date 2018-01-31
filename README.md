# Description
***

This is my "infrastructure as code" Chef repository used to setup my personal media server. It uses [Docker](https://www.docker.com/) for containerization of the applications and [ZFS](https://en.wikipedia.org/wiki/ZFS) for the data storage layer.  In addition, it uses various Python, C++, and .NET applications to fetch, process, organize, and deliver media. All of the applications communicate via RESTful API's.

There is a [companion repository](https://github.com/skingry/Dockerfiles) that contains all of the `Dockerfiles` needed to build the containers.

## Overview of Applications
***

[Certbot](https://github.com/certbot/certbot) to provide signed SSL certificates for the reverse proxy.

[Couchpotato](https://couchpota.to/) is a Python based PVR.

[Grafana](https://grafana.com/) and [InfluxDb](https://www.influxdata.com/) as the framework used for metrics collection and time-series viewing.

[Netatalk](http://netatalk.sourceforge.net/) as the LAN based file sharing server (using AFP).

[Nginx](https://www.nginx.com/) as the reverse web proxy for the web applications.

[OpenVPN](https://openvpn.net/) as the transport used to connect to remote networks securely.

[Plex Cleaner](https://github.com/ngovil21/Plex-Cleaner) is a Python script for automatic purging of consumed media on a Plex Media Server.

[Plex Media Server](https://en.wikipedia.org/wiki/Plex_(software)#Plex_Media_Server) is a media management tool with a "10-foot user interface".  It organizes personal media stored on local devices.

[PlexPy](https://github.com/drzoidberg33/plexpy) is a Python based monitoring and tracking tool for Plex Media Server.

[Resilio Sync](https://www.resilio.com/individuals/) as a torrent based file syncing utility.

[SABnzbd](http://sabnzbd.org/) is an open source binary Usenet reader written in Python.  It automates, simplifies, and streamlines downloading of binary files from Usenet sources.

[Samba](https://www.samba.org/) as the LAN based file sharing server (using SMB).

[Sonarr](https://sonarr.tv/) is a PVR for newsgroup users (with limited torrent support). It watches for new episodes of your favorite shows and when they are posted it downloads them, sorts and renames them, and optionally generates metadata for them.

[Transmission](https://www.transmissionbt.com/) is a web based BitTorrent client.