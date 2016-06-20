FROM rocker/rstudio 
MAINTAINER Javad Chamanara <chamanara@mail.com> 

# Install the python script required for "add-apt-repository" 
RUN apt-get update && apt-get install -y software-properties-common

# Sets language to UTF8 : this works in pretty much all cases 
ENV LANG en_US.UTF-8 
RUN locale-gen $LANG d

# Setup the JDK 8 repo 

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-add-repository ppa:webupd8team/java

# Install java8 
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections 
RUN apt-get update && apt-get install -y oracle-java8-installer && apt-get install -y oracle-java8-set-default

# Setup JAVA_HOME, this is useful for docker commandline

#RUN apt-get install -y oracle-java8-set-default
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/ 
RUN export JAVA_HOME

# Set the link for rJava and other applications that may need the default Java
RUN ln -s /usr/lib/jvm/java-8-oracle /usr/lib/jvm/default-java

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

ENV JDK_HOME /usr/lib/jvm/java-8-oracle
RUN export JDK_HOME
RUN R -e 'version'
#RUN R -e 'installed.packages()'
#RUN R -e 'remove.packages("RQUIS")'
RUN R -e 'devtools::install_github("JavadCh/RQUIS", ref="dev", "force=TRUE")'
#RUN R -e 'library(RQUIS)'
#RUN R -e 'rqt.versionInfo()'
#RUN R -r 'demo(package ="RQUIS", Test1)'


