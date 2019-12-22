FROM jhipster/jhipster:v6.2.0

USER root

# --------------------------------
# Configure Java
# --------------------------------
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# --------------------------------
# Install Maven 3
# --------------------------------
ARG MAVEN_VERSION=${MAVEN_VERSION:-3.6.2}
ENV MAVEN_VERSION=${MAVEN_VERSION}
ENV MAVEN_HOME=/usr/apache-maven-${MAVEN_VERSION}
ENV PATH $PATH:${MAVEN_HOME}/bin
RUN curl -sL http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  | gunzip \
  | tar x -C /usr/ \
  && ln -s ${MAVEN_HOME} /usr/maven

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

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -  
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
    
# --------------------------------
# PYTHON 3
# --------------------------------
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# --------------------------------
# JINJA2
# --------------------------------
RUN pip3 install jinja2 j2cli

# USER jhipster
