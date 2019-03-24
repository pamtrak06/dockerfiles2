FROM pamtrak06/ubuntu18.04-apache2

MAINTAINER pamtrak06 <pamtrak06@gmail.com>

# Update python
RUN apt-get update && apt-get install -y python python-dev libxml2-dev libxslt-dev software-properties-common python-pip

# Install OGC library
RUN pip install OWSLib

EXPOSE 80 443

# Define default command
CMD ["apachectl", "-D", "FOREGROUND"]

