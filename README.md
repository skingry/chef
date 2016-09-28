# Description
***

This is my "infrastructure as code" Chef repository used to setup my personal media server. It uses [Docker](https://www.docker.com/) for containerization of the applications and [ZFS](https://en.wikipedia.org/wiki/ZFS) for the data storage layer.  In addition, it uses various Python, C++, and .NET applications to fetch, process, organize, and deliver media. All of the applications communicate via RESTful API's.

There is a [companion repository](https://github.com/skingry/Dockerfiles) that contains all of the `Dockerfiles` needed to build the containers.

## Overview of Applications
***

###**Web Applications:**

[Couchpotato](https://couchpota.to/) is a Python based PVR.

[Plex Media Server](https://en.wikipedia.org/wiki/Plex_(software)#Plex_Media_Server) is a media management tool with a "10-foot user interface".  It organizes personal media stored on local devices.

[PlexPy](https://github.com/drzoidberg33/plexpy) is a Python based monitoring and tracking tool for Plex Media Server.

[Sonarr](https://sonarr.tv/) is a PVR for newsgroup users (with limited torrent support). It watches for new episodes of your favorite shows and when they are posted it downloads them, sorts and renames them, and optionally generates metadata for them.

[SABnzbd](http://sabnzbd.org/) is an open source binary Usenet reader written in Python.  It automates, simplifies, and streamlines downloading of binary files from Usenet sources.

[Transmission](https://www.transmissionbt.com/) is a web based BitTorrent client.

###**Other Applications:** 

[Nginx](https://www.nginx.com/) as the reverse web proxy for the web applications.

[Certbot](https://github.com/certbot/certbot) to provide signed SSL certificates for the reverse proxy.

[Netatalk](http://netatalk.sourceforge.net/) as the LAN based file sharing server.

[Plex Cleaner](https://github.com/ngovil21/Plex-Cleaner) is a Python script for automatic purging of consumed media on a Plex Media Server.

## Overview of Development Components
***

[Vagrant](http://vagrantup.com) is a free tool that automates the creation of VM's using VirtualBox. It provides a small set of command-line tools that kick off provisioning of a VM via VirtualBox.

[VirtualBox](http://www.virtualbox.org) is a free virtualization platform that allows the creation of virtual machines on a local workstation.


### Setup Prerequisites:
***

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) ( and corresponding VirtualBox Extension Pack )
2. Install [Vagrant](https://www.vagrantup.com/downloads.html)
3. Install the Vagrant plugin [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater)

   ```
   $ vagrant plugin install vagrant-hostsupdater
   ```
   
### Setup:
***

1. Clone the Chef repository and `cd` to it: 

   ```
   $ git clone https://github.com/skingry/chef.git
   $ cd ./chef
   $ pwd
   /Users/jdoe/Code/skingry/chef
   ```
   
2. Start the VM ( while the VM is starting, you may be prompted for your workstation password so the `/etc/hosts` file can be updated by the `vagrant-hostsupdater` plugin ):

   ```
   $ vagrant up
   Bringing machine 'default' up with 'virtualbox' provider...
   ==> default: Importing base box 'robotozon/media-server'...
   ==> default: Matching MAC address for NAT networking...
   ==> default: Checking if box 'robotozon/media-server' is up to date...
   ==> default: Setting the name of the VM: Chef
   ==> default: Clearing any previously set network interfaces...
   ==> default: Preparing network interfaces based on configuration...
       default: Adapter 1: nat
       default: Adapter 2: hostonly
   ==> default: Forwarding ports...
       default: 22 => 2222 (adapter 1)
   /// TRUNCATED OUTPUT ///
   ```
   
3. Access the Vagrant:

   ```
   $ vagrant ssh
   Welcome to Ubuntu 16.04.1 LTS (GNU/Linux 4.4.0-31-generic x86_64)

   * Documentation:  https://help.ubuntu.com/

    System information disabled due to load higher than 1.0

   Last login: Mon Feb  9 12:36:43 2015 from 10.0.2.2
   vagrant@monolith ~ $
   ```

_**--- ALL STEPS BELOW ARE PERFORMED WITHIN THE VAGRANT ---**_
 
1. Within the Vagrant, run the `bootstrap.sh` script (inside the `/chef` directory):

   ```
   $ /chef/bootstrap.sh
   ```
   
   _NOTE: This script will install required Gems, download subordinate cookbooks, install and setup ZFS, setup the data store, and install/run Chef for the first time._
   
### Usage:
***

All of the interfaces for the web applications can be accessed via web browser.  You will have to ignore the SSL warning as the certificate used is self-signed.

+ [Couchpotato](https://couchpotato.media-server.local/)
+ [Plex Media Server](https://plex.media-server.local)
+ [PlexPy](https://plexpy.media-server.local)
+ [Sonarr](https://sonarr.media-server.local)
+ [SABnzbd](https://sonarr.media-server.local)
+ [Transmission](https://transmission.media-server.local)