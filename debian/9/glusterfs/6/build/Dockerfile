# https://gluster.readthedocs.io/en/latest/Install-Guide/Install/
FROM debian:stretch
RUN apt-get update -y && \
    apt-get install -y wget software-properties-common \
                       apt-transport-https ca-certificates gnupg2
RUN export DEBID=$(grep 'VERSION_ID=' /etc/os-release | cut -d '=' -f 2 | tr -d '"')
RUN export DEBVER=$(grep 'VERSION=' /etc/os-release | grep -Eo '[a-z]+')
RUN export DEBARCH=$(dpkg --print-architecture)
RUN wget https://download.gluster.org/pub/gluster/glusterfs/6/rsa.pub && \
    apt-key add rsa.pub
RUN echo deb https://download.gluster.org/pub/gluster/glusterfs/6/LATEST/Debian/stretch/amd64/apt/ stretch main > /etc/apt/sources.list.d/gluster.list
RUN apt-get update -y && \
    apt-get install -y glusterfs-server

