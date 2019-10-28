FROM ubuntu:18.04
LABEL MAINTAINER='Jacob Motley'

ENV DEBIAN_FRONTEND=noninteractive

# update the container
RUN apt-get update && \
    apt-get -y upgrade

# install git so we can pull the adobedng exe file from the repo
RUN apt-get -y install git wget gnupg software-properties-common

# install wine
WORKDIR /home/wine_install

RUN dpkg --add-architecture i386; \
wget -nc https://dl.winehq.org/wine-builds/winehq.key; \
apt-key add winehq.key; \
apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'; \
apt update; \
apt install -y --install-recommends winehq-stable

# move dependency files for adobe dng / wine to container
WORKDIR /root/.wine/drive_c/ProgramData
ADD /drive_c/ProgramData/Adobe ./

WORKDIR /root/.wine/drive_c/windows
ADD /drive_c/windows ./

# move adobedng .exe file to wine drive
WORKDIR /root/.wine/drive_c/Program\ Files\ \(x86\)/
ADD drive_c/Program_Files_(x86)/AdobeDNGConverter.exe ./AdobeDNGConverter.exe

# create alias for adobedng
WORKDIR /root
RUN touch .bash_aliases
RUN echo "alias adobedng='wine /root/.wine/drive_c/Program\ Files\ \(x86\)/AdobeDNGConverter.exe'" > .bash_aliases

ENTRYPOINT ["/bin/bash"]