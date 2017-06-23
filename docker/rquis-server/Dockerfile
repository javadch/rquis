FROM 	rocker/rstudio:3.3.2
# FROM cardcorp/r-java

MAINTAINER Javad Chamanara <chamanara@mail.com> 

# Install the python script required for "add-apt-repository" 
RUN 	apt-get update && apt-get install -y software-properties-common

# Sets language to UTF8 : this works in pretty much all cases 
ENV 	LANG en_US.UTF-8 
RUN 	locale-gen $LANG d



# Setup the JDK 8 repo 

#RUN 	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
#RUN 	apt-add-repository ppa:webupd8team/java

RUN \
    echo "===> add webupd8 repository..."  && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list  && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list  && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886  && \
    apt-get update


# Install java8 
RUN 	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections 
RUN 	apt-get update && apt-get install -y oracle-java8-installer && apt-get install -y oracle-java8-set-default

# Setup JAVA_HOME, this is useful for docker commandline

ENV 	JAVA_HOME /usr/lib/jvm/java-8-oracle/ 
RUN 	export JAVA_HOME

ENV 	JDK_HOME /usr/lib/jvm/java-8-oracle
RUN 	export JDK_HOME

# Set the link for rJava and other applications that may need the default Java
RUN 	ln -s /usr/lib/jvm/java-8-oracle /usr/lib/jvm/default-java

# SET JDK for R
RUN 	R CMD javareconf

# Show java version (for debugging) 
# RUN java -version

# SET R CRAN repo
#RUN 	echo 'deb http://cloud.r-project.org/bin/linux/debian jessie/' | tee -a /etc/apt/sources.list.d/r.list
#RUN  	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN 	apt-get update && apt-get install -y r-base

# Installing pre-requisites of rJava
RUN	apt-get install -y libicu-dev
#RUN	apt-get install -y xz-devel
#RUN	apt-get install -y pcre-devel

RUN 	su - -c "R -e \"install.packages('DBI')\""
RUN 	su - -c "R -e \"install.packages('RPostgreSQL')\""

#RUN  	apt-get install r-cran-rjava
RUN 	wget http://www.rforge.net/rJava/snapshot/rJava_0.9-9.tar.gz
RUN 	R CMD INSTALL rJava_0.9-9.tar.gz

RUN 	su - -c "R -e \"install.packages('devtools', repos = 'http://cran.rstudio.com/')\""




# Install rquis package using devtools

#RUN 	R -e 'version'
#RUN 	R -e 'installed.packages()'
#RUN 	R -e 'remove.packages("RQUIS")'

RUN 	R -e 'devtools::install_github("JavadCh/RQUIS", ref="dev", "force=TRUE")'
#RUN 	R -e 'library(RQUIS)'

#RUN 	R -e 'rqt.versionInfo()'
#RUN 	R -r 'demo(package ="RQUIS", Test1)'


# Create a list of users as the test subjects
# for each user copy the test data into /home/data
# the data is the csv, the excel, the survey, the connection string to the DB, etc.

# RUN userdel -r mynewuser
# Create user and copy the data files one-by-one (docker recomendation)

#deluser --remove-home user1 \

RUN 	useradd user1 \
 	&& echo "user1:pass1" | chpasswd \
 	&& rm -rf /home/user1 \
	&& mkdir  /home/user1 \
	&& chown user1:user1 /home/user1 \
	&& addgroup user1 staff
COPY 	/context /home/user1/


RUN 	useradd user2 \
 	&& echo "user2:pass2" | chpasswd \
 	&& rm -rf /home/user2 \
	&& mkdir  /home/user2 \
	&& chown user2:user2 /home/user2 \
	&& addgroup user2 staff
COPY 	/context /home/user2/

RUN 	useradd user3 \
 	&& echo "user3:pass3" | chpasswd \
 	&& rm -rf /home/user3 \
	&& mkdir  /home/user3 \
	&& chown user3:user3 /home/user3 \
	&& addgroup user3 staff
COPY 	/context /home/user3/

RUN 	useradd user4 \
 	&& echo "user4:pass4" | chpasswd \
 	&& rm -rf /home/user4 \
	&& mkdir  /home/user4 \
	&& chown user4:user4 /home/user4 \
	&& addgroup user4 staff
COPY 	/context /home/user4/

RUN 	useradd user5 \
 	&& echo "user5:pass5" | chpasswd \
 	&& rm -rf /home/user5 \
	&& mkdir  /home/user5 \
	&& chown user5:user5 /home/user5 \
	&& addgroup user5 staff
COPY 	/context /home/user5/

RUN 	useradd user6 \
 	&& echo "user6:pass6" | chpasswd \
 	&& rm -rf /home/user6 \
	&& mkdir  /home/user6 \
	&& chown user6:user6 /home/user6 \
	&& addgroup user6 staff
COPY 	/context /home/user6/

RUN 	useradd user7 \
 	&& echo "user7:pass7" | chpasswd \
 	&& rm -rf /home/user7 \
	&& mkdir  /home/user7 \
	&& chown user7:user7 /home/user7 \
	&& addgroup user7 staff
COPY 	/context /home/user7/

RUN 	useradd user8 \
 	&& echo "user8:pass8" | chpasswd \
 	&& rm -rf /home/user8 \
	&& mkdir  /home/user8 \
	&& chown user8:user8 /home/user8 \
	&& addgroup user8 staff
COPY 	/context /home/user8/

RUN 	useradd user9 \
 	&& echo "user9:pass9" | chpasswd \
 	&& rm -rf /home/user9 \
	&& mkdir  /home/user9 \
	&& chown user9:user9 /home/user9 \
	&& addgroup user9 staff
COPY 	/context /home/user9/

RUN 	useradd user10 \
 	&& echo "user10:pass10" | chpasswd \
 	&& rm -rf /home/user10 \
	&& mkdir  /home/user10 \
	&& chown user10:user10 /home/user10 \
	&& addgroup user10 staff
COPY 	/context /home/user10/

RUN 	useradd user11 \
 	&& echo "user11:pass11" | chpasswd \
 	&& rm -rf /home/user11 \
	&& mkdir  /home/user11 \
	&& chown user11:user11 /home/user11 \
	&& addgroup user11 staff
COPY 	/context /home/user11/

RUN 	useradd user12 \
 	&& echo "user12:pass12" | chpasswd \
 	&& rm -rf /home/user12 \
	&& mkdir  /home/user12 \
	&& chown user12:user12 /home/user12 \
	&& addgroup user12 staff
COPY 	/context /home/user12/

RUN 	useradd user13 \
 	&& echo "user13:pass13" | chpasswd \
 	&& rm -rf /home/user13 \
	&& mkdir  /home/user13 \
	&& chown user13:user13 /home/user13 \
	&& addgroup user13 staff
COPY 	/context /home/user13/

RUN 	useradd user14 \
 	&& echo "user14:pass14" | chpasswd \
 	&& rm -rf /home/user14 \
	&& mkdir  /home/user14 \
	&& chown user14:user14 /home/user14 \
	&& addgroup user14 staff
COPY 	/context /home/user14/

RUN 	useradd user15 \
 	&& echo "user15:pass15" | chpasswd \
 	&& rm -rf /home/user15 \
	&& mkdir  /home/user15 \
	&& chown user15:user15 /home/user15 \
	&& addgroup user15 staff
COPY 	/context /home/user15/

RUN 	useradd user16 \
 	&& echo "user16:pass16" | chpasswd \
 	&& rm -rf /home/user16 \
	&& mkdir  /home/user16 \
	&& chown user16:user16 /home/user16 \
	&& addgroup user16 staff
COPY 	/context /home/user16/

RUN 	useradd user17 \
 	&& echo "user17:pass17" | chpasswd \
 	&& rm -rf /home/user17 \
	&& mkdir  /home/user17 \
	&& chown user17:user17 /home/user17 \
	&& addgroup user17 staff
COPY 	/context /home/user17/

RUN 	useradd user18 \
 	&& echo "user18:pass18" | chpasswd \
 	&& rm -rf /home/user18 \
	&& mkdir  /home/user18 \
	&& chown user18:user18 /home/user18 \
	&& addgroup user18 staff
COPY 	/context /home/user18/

RUN 	useradd user19 \
 	&& echo "user19:pass19" | chpasswd \
 	&& rm -rf /home/user19 \
	&& mkdir  /home/user19 \
	&& chown user19:user19 /home/user19 \
	&& addgroup user19 staff
COPY 	/context /home/user19/

RUN 	useradd user20 \
 	&& echo "user20:pass20" | chpasswd \
 	&& rm -rf /home/user20 \
	&& mkdir  /home/user20 \
	&& chown user20:user20 /home/user20 \
	&& addgroup user20 staff
COPY 	/context /home/user20/

RUN 	useradd user21 \
 	&& echo "user21:pass21" | chpasswd \
 	&& rm -rf /home/user21 \
	&& mkdir  /home/user21 \
	&& chown user21:user21 /home/user21 \
	&& addgroup user21 staff
COPY 	/context /home/user21/

RUN 	useradd user22 \
 	&& echo "user22:pass22" | chpasswd \
 	&& rm -rf /home/user22 \
	&& mkdir  /home/user22 \
	&& chown user22:user22 /home/user22 \
	&& addgroup user22 staff
COPY 	/context /home/user22/

RUN 	useradd user23 \
 	&& echo "user23:pass23" | chpasswd \
 	&& rm -rf /home/user23 \
	&& mkdir  /home/user23 \
	&& chown user23:user23 /home/user23 \
	&& addgroup user23 staff
COPY 	/context /home/user23/

RUN 	useradd user24 \
 	&& echo "user24:pass24" | chpasswd \
 	&& rm -rf /home/user24 \
	&& mkdir  /home/user24 \
	&& chown user24:user24 /home/user24 \
	&& addgroup user24 staff
COPY 	/context /home/user24/



