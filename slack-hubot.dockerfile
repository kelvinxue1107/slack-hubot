# Version 0.1
FROM centos:latest
MAINTAINER kelvin.xue@outlook.com/citrix.com
#RUN yum install perl-XML-Simple
RUN yum install -y gcc-c++ make
RUN curl -sL https://rpm.nodesource.com/setup_8.x | bash
RUN yum install -y nodejs
RUN yum install -y openssl
RUN npm install -g yo generator-hubot
RUN adduser -p `openssl passwd -1 -salt "12345678" hubot` hubot
#USER hubot
#WORKDIR /home/hubot
#EXPOSE 8080
