FROM ubuntu:18.04
LABEL MAINTAINER='Jacob Motley'

ENV DEBIAN_FRONTEND=noninteractive

# update the container
RUN apt-get update && \
    apt-get -y upgrade

# install git so we can pull the adobedng exe file from the repo
RUN apt-get -y install git

# install necessary packages for using dpkg / apt functions
# RUN apt-get -y install

# install wine
WORKDIR /home/wine_install

RUN \
dpkg --add-architecture i386 \
wget -nc https://dl.winehq.org/wine-builds/winehq.key \
apt-key add winehq.key \
apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' \
apt update \
apt install --install-recommends winehq-stable

# move adobedng .exe file to wine drive
WORKDIR /root/.wine/drive_c/Program\ Files\ \(x86\)/
ADD AdobeDNGConverter_9.1.1.exe ./AdobeDNGConverter_9.1.1.exe

# create alias for adobedng
WORKDIR /home
RUN touch .bash_aliases \
echo "alias adobedng='wine /root/.wine/drive_c/Program\ Files\ \(x86\)/AdobeDNG/AdobeDNGConverter_9.1.1.exe'" > .bash_aliases

# run test on sample images
WORKDIR /home/adobedng_test
ADD test_images ./test_images
# run test
RUN for f in ./BRIT_test_set/*.CR2; do adobedng -c $f -d ./test_output -o "${f%.CR2}.DNG"; done

ENTRYPOINT ["/bin/bash"]