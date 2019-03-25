
FROM ubuntu:18.04
MAINTAINER pamtrak06 <pamtrak06@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q && \
    apt-get install -y wget attr software-properties-common psmisc

RUN add-apt-repository ppa:gluster/glusterfs-6 && \
	apt-get update -q && \
	apt-get install -y glusterfs-server

VOLUME ["/data", "/var/lib/glusterd"]
EXPOSE 111 111/udp 24007 24009 49152
CMD ["/usr/sbin/glusterd","-N"]