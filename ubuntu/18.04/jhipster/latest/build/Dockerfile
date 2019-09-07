FROM jhipster/jhipster

USER root

# --------------------------------
# DOCKER
# --------------------------------
# to install envsubst (gettext-base)
RUN apt-get -y update  && \ 
    apt-get -y install curl \ 
        apt-transport-https \ 
        ca-certificates \ 
        curl \ 
        gnupg2 \ 
        software-properties-common \
        gettext-base && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#ADD debian-docker.gpg ./  
#RUN apt-key add ./debian-docker.gpg  

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -  
# ADD gpg .
# RUN apt-key add gpg && rm -f gpg
# check 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88 
RUN apt-key fingerprint 0EBFCD88 

RUN add-apt-repository \ 
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \ 
   $(lsb_release -cs) \ 
   stable" 

RUN apt-get update -y && \
    apt-cache policy docker-ce && \
    apt-get -y install docker-ce 

RUN usermod -aG docker root && \
    usermod -aG docker jhipster

# --------------------------------
# DOCKER COMPOSE
# --------------------------------
RUN curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

USER jhipster
