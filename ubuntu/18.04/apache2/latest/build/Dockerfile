FROM ubuntu:18.04

MAINTAINER pamtrak06 <pamtrak06@gmail.com>

# Update system and install Apache
RUN apt-get update && apt-get install -y apache2 ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure localhost in Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# VOLUMES /var/www/html
WORKDIR /etc/apache2

EXPOSE 80 443

CMD ["apachectl", "-D", "FOREGROUND"]

