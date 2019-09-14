FROM ubuntu:16.04
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Update my package repos
RUN apt-get update

# Install the build tool chain
RUN apt-get install -y git-core subversion build-essential gcc-multilib sudo vim ruby zsh \
                       libncurses5-dev zlib1g-dev gawk flex gettext wget unzip python curl \
                       fontconfig

# Add a non-priviledged build user
RUN echo 'build ALL = (ALL) NOPASSWD:ALL' >> /etc/sudoers
