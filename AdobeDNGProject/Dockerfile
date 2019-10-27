FROM ubuntu:18.04
LABEL MAINTAINER='Jacob Motley'

ENV DEBIAN_FRONTEND=noninteractive

# update the container
RUN apt-get update && \
    apt-get -y upgrade

# install git so we can pull the adobedng exe file from the repo
RUN apt-get -y install git wget gnupg software-properties-common

# install necessary packages for using dpkg / apt functions
# RUN apt-get -y install

# install wine
WORKDIR /home/wine_install

RUN dpkg --add-architecture i386; \
wget -nc https://dl.winehq.org/wine-builds/winehq.key; \
apt-key add winehq.key; \
apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'; \
apt update; \
apt install -y --install-recommends winehq-stable

# move adobedng .exe file to wine drive
WORKDIR /root/.wine/drive_c/Program\ Files\ \(x86\)/
ADD AdobeDNGConverter_9.1.1.exe ./AdobeDNGConverter_9.1.1.exe

# create alias for adobedng
WORKDIR /root
RUN touch .bash_aliases
RUN echo "alias adobedng='wine /root/.wine/drive_c/Program\ Files\ \(x86\)/AdobeDNGConverter_9.1.1.exe'" > .bash_aliases

ENTRYPOINT ["/bin/bash"]