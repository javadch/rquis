#FROM rocker/rstudio 
FROM rocker/rstudio-stable:3.3.2
# FROM cardcorp/r-java

MAINTAINER Javad Chamanara <chamanara@mail.com> 

# Install the python script required for "add-apt-repository" 
RUN apt-get update && apt-get install -y software-properties-common

# Sets language to UTF8 : this works in pretty much all cases 
ENV LANG en_US.UTF-8 
RUN locale-gen $LANG d

# Create a list of users as the test subjects
# for each user copy the test data into /home/data
# the data is the csv, the excel, the survey, the connection string to the DB, etc.

# RUN userdel -r mynewuser
# Create user and copy the data files one-by-one (docker recomendation)

#deluser --remove-home user1 \
RUN 	useradd user1
RUN 	echo "user1:pass1" | chpasswd
RUN 	rm -rf /home/user1
RUN	mkdir  /home/user1
COPY /data/airports.csv /home/user1/data/airports.csv
COPY /data/airportLocations.xlsx /home/user1/data/airportLocations.xlsx
RUN	chown user1:user1 /home/user1
RUN	addgroup user1 staff

#RUN useradd -m -p pass1 -s /bin/bash user1
#RUN rm -rf /home/user1 
#RUN mkdir  /home/user1
#COPY /data/airports.csv /home/user1/data/airports.csv
#COPY /data/airportLocations.xlsx /home/user1/data/airportLocations.xlsx
#RUN chown user1:rstudio /home/user1 
#RUN addgroup user1 staff

#RUN useradd -ms /bin/bash user2
#RUN useradd -ms /bin/bash user3
#RUN useradd -ms /bin/bash user4
#RUN useradd -ms /bin/bash user5
#RUN useradd -ms /bin/bash user6
#RUN useradd -ms /bin/bash user7
#RUN useradd -ms /bin/bash user8
#RUN useradd -ms /bin/bash user9
#RUN useradd -ms /bin/bash user10

#RUN useradd -ms /bin/bash user11
#RUN useradd -ms /bin/bash user12
#RUN useradd -ms /bin/bash user13
#RUN useradd -ms /bin/bash user14
#RUN useradd -ms /bin/bash user15
#RUN useradd -ms /bin/bash user16
#RUN useradd -ms /bin/bash user17
#RUN useradd -ms /bin/bash user18
#RUN useradd -ms /bin/bash user19
#RUN useradd -ms /bin/bash user20



# Install Oracle Java 8 
#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
#RUN apt-add-repository ppa:webupd8team/java
#RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections 
#RUN apt-get update && apt-get install -y oracle-java8-installer && apt-get install -y oracle-java8-set-default
#ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/ 
#RUN export JAVA_HOME


# Install OpenJDK 8 
RUN apt-get install -y openjdk-8*
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# Set the link for rJava and other applications that may need the default Java
RUN ln -s JAVA_HOME /usr/lib/jvm/default-java

# Used by RQUIS 
ENV JDK_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JDK_HOME

# Show java version (for debugging) 
# RUN java -version

# SET R CRAN repo
#RUN echo 'deb http://cloud.r-project.org/bin/linux/ubuntu trusty/' | tee -a /etc/apt/sources.list.d/r.list
##xenial
#RUN  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E084DAB9
#RUN apt-get update && apt-get install -y r-base

RUN su - -c "R -e \"install.packages('DBI')\""
RUN su - -c "R -e \"install.packages('RPostgreSQL')\""
RUN  	apt-get install -y r-cran-rjava
RUN su - -c "R -e \"install.packages('devtools', repos = 'http://cran.rstudio.com/')\""

# Install rquis package using devtools
# RUN 	R -e 'library(devtools)'
# RUN 	R -e 'library(rJava)'

RUN R -e 'version'
#RUN R -e 'installed.packages()'
#RUN R -e 'remove.packages("RQUIS")'
RUN R -e 'devtools::install_github("JavadCh/RQUIS", ref="dev", "force=TRUE")'
RUN 	R -e 'library(RQUIS)'
#RUN R -e 'rqt.versionInfo()'
#RUN R -r 'demo(package ="RQUIS", Test1)'


