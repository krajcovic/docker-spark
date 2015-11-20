############################################################
# Dockerfile to build Monet+ container images
# Based on CentOS 7
############################################################

# Base images
FROM krajcovic/centos-base:latest

MAINTAINER Dusan Krajcovic

# Variables
ENV container docker

################## BEGIN INSTALLATION ######################

RUN yum -y update --skip-broken;yum install -y jdk1.8.0_25 wget;

RUN mkdir /opt/spark; mkdir /opt/spark/install
RUN cd /opt/spark/install;wget http://apache.miloslavbrada.cz/spark/spark-1.5.2/spark-1.5.2.tgz
ADD spark-1.5.2.tgz.md5 /opt/spark/install
RUN cd /opt/spark/install/;md5sum -c spark-1.5.2.tgz.md5
RUN gunzip /opt/spark/install/spark-1.5.2.tgz
RUN cd /opt/spark/;tar -xvf install/spark-1.5.2.tar

# Set java
RUN export JAVA_HOME=/usr/java/default/bin/java
RUN export export PATH=$PATH:/usr/java/default/bin

# Build spark
RUN /opt/spark/spark-1.5.2/make-distribution.sh;


##################### INSTALLATION END #####################

WORKDIR "/opt/spark/"

# CMD ["source /etc/environment"]

ENTRYPOINT ["/opt/spark/spark-1.5.2/bin/pyspark"]

