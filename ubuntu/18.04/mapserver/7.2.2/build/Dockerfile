FROM pamtrak06/ubuntu18.04-apache2-python
USER root

MAINTAINER pamtrak06 <pamtrak06@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

# Install mapcache compilation prerequisites
RUN apt-get update && apt-get install -y software-properties-common g++ make cmake wget git

# Install mapcache dependencies provided by Ubuntu repositories
RUN apt-get install -y \
	libxml2-dev \
	libxslt1-dev \
	libproj-dev \
	libfribidi-dev \
	libcairo2-dev \
	librsvg2-dev \
	libmysqlclient-dev \
	libpq-dev \
	libcurl4-gnutls-dev \
	libexempi-dev \
	libgdal-dev \
	libgeos-dev

# Install libharfbuzz from source as it is not in a repository
RUN apt-get install -y bzip2
RUN cd /tmp && wget http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-2.3.1.tar.bz2 && \
    tar xjf harfbuzz-2.3.1.tar.bz2 && \
    cd harfbuzz-2.3.1 && \
    ./configure && \
    make && \
    make install && \
    ldconfig

RUN apt-get install -y protobuf-compiler

# Install Mapserver itself
RUN git clone https://github.com/mapserver/mapserver/ /usr/local/src/mapserver && \
    cd /usr/local/src/mapserver; git checkout rel-7-2-2

# Compile Mapserver for Apache
RUN mkdir /usr/local/src/mapserver/build && \
    cd /usr/local/src/mapserver/build && \
    cmake ../ -DWITH_THREAD_SAFETY=1 \
        -DWITH_PROTOBUFC=0 \
        -DWITH_PROJ=1 \
        -DWITH_KML=1 \
        -DWITH_SOS=1 \
        -DWITH_WMS=1 \
        -DWITH_FRIBIDI=1 \
        -DWITH_HARFBUZZ=1 \
        -DWITH_ICONV=1 \
        -DWITH_CAIRO=1 \
        -DWITH_RSVG=1 \
        -DWITH_MYSQL=1 \
        -DWITH_GEOS=1 \
        -DWITH_POSTGIS=1 \
        -DWITH_GDAL=1 \
        -DWITH_OGR=1 \
        -DWITH_CURL=1 \
        -DWITH_CLIENT_WMS=1 \
        -DWITH_CLIENT_WFS=1 \
        -DWITH_WFS=1 \
        -DWITH_WCS=1 \
        -DWITH_LIBXML2=1 \
        -DWITH_GIF=1 \
        -DWITH_EXEMPI=1 \
        -DWITH_XMLMAPFILE=1 \
        -DWITH_FCGI=0 && \
    make && \
    make install && \
    ldconfig


# To reconcile this, the multiverse repository must be added to the apt sources.
#RUN echo 'deb http://security.ubuntu.com/ubuntu bionic multiverse' >> /etc/apt/sources.list
#RUN echo 'deb http://security.ubuntu.com/ubuntu bionic-updates multiverse' >> /etc/apt/sources.list
#RUN echo 'deb http://security.ubuntu.com/ubuntu bionic-security multiverse' >> /etc/apt/sources.list

# Install PHP and necessary modules (instead of libapache2-mod-fastcgi)
RUN wget https://mirrors.edge.kernel.org/ubuntu/pool/multiverse/liba/libapache-mod-fastcgi/libapache2-mod-fastcgi_2.4.7~0910052141-1.2_amd64.deb
RUN dpkg -i libapache2-mod-fastcgi_2.4.7~0910052141-1.2_amd64.deb
RUN apt-get update -y && apt-get install -yq --no-install-recommends php7.2-fpm php7.2

# Enable these Apache modules
RUN a2enmod actions cgi alias

# Apache configuration for PHP-FPM
COPY php7-fpm.conf /etc/apache2/conf-available/

# Create the following PHP file in the document root /var/www
RUN echo '<?php phpinfo();' > /var/www/info.php
# result in : http://your-server-ip/info.php
# Under Server API at the top you should see FPM/FastCGI.

# Link to cgi-bin executable
RUN chmod o+x /usr/local/bin/mapserv
RUN ln -s /usr/local/bin/mapserv /usr/lib/cgi-bin/mapserv
# result in http://yourhostname.com/cgi-bin/mapserv

# Volumes: override it
# VOLUME ["/var/www/html", "/var/log/apache2", "/etc/apache2", "/usr/local/apache2"]

# Expose ports: override for needs
# EXPOSE 80 443

# Define default command
CMD ["apachectl", "-D", "FOREGROUND"]
