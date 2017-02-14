FROM rocker/tidyverse:3.3.2
MAINTAINER "Javad Chamanara" chamanara@gmail.com

## Install Java 
RUN apt-get update \
    && apt-get install -y gnupg2 \
    && apt-get install -y software-properties-common
	
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list \
    && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 \
    && echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections \
    && apt-get update \
    && apt-get install -y oracle-java8-installer \
    && update-java-alternatives --set java-8-oracle \
    && update-alternatives --display java \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && R CMD javareconf


RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> ~/.bashrc
RUN echo "export JDK_HOME=/usr/lib/jvm/java-8-oracle" >> ~/.bashrc


## make sure Java can be found in rApache and other daemons not looking in R ldpaths
RUN echo "/usr/lib/jvm/java-8-oracle/jre/lib/amd64/server/" > /etc/ld.so.conf.d/rJava.conf
RUN /sbin/ldconfig

## Install some external dependencies. 
## Install rJava
RUN apt-get update \
  && apt-get install -y --no-install-recommends  \
    libbz2-dev \
    libcairo2-dev \
    libgdal-dev \
    libicu-dev \
    liblzma-dev \
    libproj-dev \
    libgeos-dev \
    libgsl0-dev \
    librdf0-dev \
    librsvg2-dev \
    libv8-dev \
    libxcb1-dev \
    libxdmcp-dev \
    libxslt1-dev \
    libxt-dev \
    mdbtools \
    netcdf-bin \
  && . /etc/environment \
  && install2.r --error \
    --repos 'http://www.bioconductor.org/packages/release/bioc' \
    --repos $MRAN \ 
    --deps TRUE \
    devtools dplyr ggplot2 formatR rJava DBI RPostgreSQL \
  && R CMD javareconf \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/ \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## Install RQUIS. This is the development version of the library.
## When the docker file is stable, the master branch should be used.
RUN R -e 'devtools::install_github("JavadCh/RQUIS", ref="dev", "force=TRUE")'


## Create users for the evaluation
RUN 	useradd user1 \
 	&& echo "user1:pass1" | chpasswd \
 	&& rm -rf /home/user1 \
	&& mkdir  /home/user1 \
	&& chown user1:user1 /home/user1 \
	&& addgroup user1 staff \
	&& useradd user2 \
 	&& echo "user2:pass2" | chpasswd \
 	&& rm -rf /home/user2 \
	&& mkdir  /home/user2 \
	&& chown user2:user2 /home/user2 \
	&& addgroup user2 staff \
 	&& useradd user3 \
 	&& echo "user3:pass3" | chpasswd \
 	&& rm -rf /home/user3 \
	&& mkdir  /home/user3 \
	&& chown user3:user3 /home/user3 \
	&& addgroup user3 staff \
 	&& useradd user4 \
 	&& echo "user4:pass4" | chpasswd \
 	&& rm -rf /home/user4 \
	&& mkdir  /home/user4 \
	&& chown user4:user4 /home/user4 \
	&& addgroup user4 staff \
 	&& useradd user5 \
 	&& echo "user5:pass5" | chpasswd \
 	&& rm -rf /home/user5 \
	&& mkdir  /home/user5 \
	&& chown user5:user5 /home/user5 \
	&& addgroup user5 staff \
 	&& useradd user6 \
 	&& echo "user6:pass6" | chpasswd \
 	&& rm -rf /home/user6 \
	&& mkdir  /home/user6 \
	&& chown user6:user6 /home/user6 \
	&& addgroup user6 staff \
 	&& useradd user7 \
 	&& echo "user7:pass7" | chpasswd \
 	&& rm -rf /home/user7 \
	&& mkdir  /home/user7 \
	&& chown user7:user7 /home/user7 \
	&& addgroup user7 staff \
 	&& useradd user8 \
 	&& echo "user8:pass8" | chpasswd \
 	&& rm -rf /home/user8 \
	&& mkdir  /home/user8 \
	&& chown user8:user8 /home/user8 \
	&& addgroup user8 staff \
 	&& useradd user9 \
 	&& echo "user9:pass9" | chpasswd \
 	&& rm -rf /home/user9 \
	&& mkdir  /home/user9 \
	&& chown user9:user9 /home/user9 \
	&& addgroup user9 staff \
 	&& useradd user10 \
 	&& echo "user10:pass10" | chpasswd \
 	&& rm -rf /home/user10 \
	&& mkdir  /home/user10 \
	&& chown user10:user10 /home/user10 \
	&& addgroup user10 staff \
 	&& useradd user11 \
 	&& echo "user11:pass11" | chpasswd \
 	&& rm -rf /home/user11 \
	&& mkdir  /home/user11 \
	&& chown user11:user11 /home/user11 \
	&& addgroup user11 staff \
	&& useradd user12 \
 	&& echo "user12:pass12" | chpasswd \
 	&& rm -rf /home/user12 \
	&& mkdir  /home/user12 \
	&& chown user12:user12 /home/user12 \
	&& addgroup user12 staff

## Copy the files needed for evaluation
COPY 	contextData /home/user1/
COPY 	contextData /home/user2/
COPY 	contextData /home/user3/
COPY 	contextData /home/user4/
COPY 	contextData /home/user5/
COPY 	contextData /home/user6/
COPY 	contextData /home/user7/
COPY 	contextData /home/user8/
COPY 	contextData /home/user9/
COPY 	contextData /home/user10/
COPY 	contextData /home/user11/
COPY 	contextData /home/user12/

## httr authentication uses this port
EXPOSE 8787
ENV HTTR_LOCALHOST 0.0.0.0


