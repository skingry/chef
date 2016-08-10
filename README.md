# Description
***

This is my "infrastructure as code" Chef repository used to setup my media server. It uses [Docker](https://www.docker.com/) for containerization of the applications and [ZFS](https://en.wikipedia.org/wiki/ZFS) for the data storage layer.  It uses various Python, C++, and .NET applications to fetch, process, organize, and deliver media. All of the applications talk to each other via RESTful API's.

Each `Dockerfile` in the `Docker` directory calls a specific recipe in this Chef repo to facilitate the configuration of the container during build.  In addition, this repository is linked to the public [Docker Hub](https://hub.docker.com/r/skingry) to allow automated builds of each of the containers when code updates are pushed.

## Overview of Applications
***

[Couchpotato](https://couchpota.to/) is a Python based PVR.

[Plex Media Server](https://en.wikipedia.org/wiki/Plex_(software)#Plex_Media_Server) is a media management tool with a "10-foot user interface".  It organizes personal media stored on local devices.

[PlexPy](https://github.com/drzoidberg33/plexpy) is a Python based monitoring and tracking tool for Plex Media Server.

[Plex Cleaner](https://github.com/ngovil21/Plex-Cleaner) is a Python script for automatic deletion of consumed media on a Plex Media Server.

[Sonarr](https://sonarr.tv/) is a PVR for newsgroup users (with limited torrent support). It watches for new episodes of your favorite shows and when they are posted it downloads them, sorts and renames them, and optionally generates metadata for them.

[SABnzbd](http://sabnzbd.org/) is an open source binary Usenet reader written in Python.  It automates, simplifies, and streamlines downloading of binary files from Usenet sources.

[Transmission](https://www.transmissionbt.com/) is a web based BitTorrent client.

Other applications used are: [nginx](https://www.nginx.com/) as a reverse web proxy, [Let's Encrypt](https://letsencrypt.org/) to provide signed SSL certificates for the nginx reverse proxy, and [netatalk](http://netatalk.sourceforge.net/) as a LAN based file sharing server.

## Overview of Development Components
***

[Vagrant](http://vagrantup.com) is a free tool that automates the creation of VM's using VirtualBox. It provides a small set of command-line tools that kick off provisioning of a VM via VirtualBox.

[VirtualBox](http://www.virtualbox.org) is a free virtualization platform that allows the creation of virtual machines on a local workstation.


### Development Setup Prerequisites:
***

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) ( and corresponding VirtualBox Extension Pack )
2. Install [Vagrant](https://www.vagrantup.com/downloads.html)
3. Install the Vagrant plugin [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater)

   ```
   $ vagrant plugin install vagrant-hostsupdater
   ```
   
### Development Setup:
***

1. Clone the Chef repository and `cd` to it: 

   ```
   $ git clone https://github.com/skingry/media-server.git
   $ cd ./media-server
   $ pwd
   /Users/jdoe/Code/skingry/media-server
   ```
   
2. Install the Gem bundle:

    ```
    $ bundler install
    ```
    
3. Install the subordinate cookbooks:

   ```
   $ berks vendor cookbooks
   ```
   
4. Start the VM ( while the VM is starting, you may be prompted for your workstation password so the `/etc/hosts` file can be updated by the `vagrant-hostsupdater` plugin ):

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
   
5. Access the Vagrant:

   ```
   $ vagrant ssh
   Welcome to Ubuntu 14.04.1 LTS (GNU/Linux 3.13.0-45-generic x86_64)

   * Documentation:  https://help.ubuntu.com/

    System information disabled due to load higher than 1.0

   Last login: Mon Feb  9 12:36:43 2015 from 10.0.2.2
   vagrant@monolith ~ $
   ```

_**--- ALL STEPS BELOW ARE PERFORMED WITHIN THE VAGRANT ---**_
 
1. Within the Vagrant, `cd` to the Chef directory and run the `bootstrap.sh` script:

   ```
   $ cd /chef
   $ ./bootstrap.sh
   ```
   
   _NOTE: This script will install ZFS, setup the data store, and install/run Chef for the first time._
   
_**TODO: Add more documentation about the setup of the applications and provisioning a production system.**_

