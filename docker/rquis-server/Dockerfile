FROM rocker/rstudio 
MAINTAINER Javad Chamanara <chamanara@mail.com> 

# Install the python script required for "add-apt-repository" 
RUN apt-get update && apt-get install -y software-properties-common

# Sets language to UTF8 : this works in pretty much all cases 
ENV LANG en_US.UTF-8 
RUN locale-gen $LANG d

# Create a list of users as the test subjects
# for each user copy the test data into /home/data
# the data is the csv, the excel, the survey, the connection string to the DB, etc.

RUN useradd -ms /bin/bash user1
USER user1
# set password
WORKDIR /home/user1
# copy...
COPY /data/airports.csv /home/user1/data/airports.csv
COPY /data/airportLocations.xlsx /home/user1/data/airportLocations.xlsx

RUN useradd -ms /bin/bash user2
RUN useradd -ms /bin/bash user3
RUN useradd -ms /bin/bash user4
RUN useradd -ms /bin/bash user5
RUN useradd -ms /bin/bash user6
RUN useradd -ms /bin/bash user7
RUN useradd -ms /bin/bash user8
RUN useradd -ms /bin/bash user9
RUN useradd -ms /bin/bash user10

RUN useradd -ms /bin/bash user11
RUN useradd -ms /bin/bash user12
RUN useradd -ms /bin/bash user13
RUN useradd -ms /bin/bash user14
RUN useradd -ms /bin/bash user15
RUN useradd -ms /bin/bash user16
RUN useradd -ms /bin/bash user17
RUN useradd -ms /bin/bash user18
RUN useradd -ms /bin/bash user19
RUN useradd -ms /bin/bash user20


#switch back to the root user
USER root


# Setup the JDK 8 repo 


# Install Oracle Java 8 
#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
#RUN apt-add-repository ppa:webupd8team/java
#RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections 
#RUN apt-get update && apt-get install -y oracle-java8-installer && apt-get install -y oracle-java8-set-default
#ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/ 
#RUN export JAVA_HOME


# Install OpenJDK 8 
sudo apt-get install default-jdk
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/
RUN export JAVA_HOME

# Set the link for rJava and other applications that may need the default Java
RUN ln -s JAVA_HOME /usr/lib/jvm/default-java

# Used by RQUIS 
ENV JDK_HOME JAVA_HOME
RUN export JDK_HOME

# Show java version (for debugging) 
# RUN java -version

# SET R CRAN repo
RUN echo 'deb http://cloud.r-project.org/bin/linux/ubuntu trusty/' | tee -a /etc/apt/sources.list.d/r.list
RUN  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E084DAB9
RUN apt-get update && apt-get install -y r-base

RUN su - -c "R -e \"install.packages('DBI')\""
RUN su - -c "R -e \"install.packages('RPostgreSQL')\""

RUN su - -c "R -e \"install.packages('rJava', repos = 'http://cran.rstudio.com/')\""
RUN su - -c "R -e \"install.packages('devtools', repos = 'http://cran.rstudio.com/')\""

# Install rquis package using devtools
RUN R -e 'library(devtools)'
RUN R -e 'library(rJava)'

RUN R -e 'version'
#RUN R -e 'installed.packages()'
#RUN R -e 'remove.packages("RQUIS")'
RUN R -e 'devtools::install_github("JavadCh/RQUIS", ref="dev", "force=TRUE")'
#RUN R -e 'library(RQUIS)'
#RUN R -e 'rqt.versionInfo()'
#RUN R -r 'demo(package ="RQUIS", Test1)'


