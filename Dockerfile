# Version 0.1
FROM centos:latest
MAINTAINER kelvin.xue@outlook.com/citrix.com
#RUN yum install perl-XML-Simple
RUN yum install -y gcc-c++ make
RUN curl -sL https://rpm.nodesource.com/setup_8.x | bash
RUN yum install -y nodejs
RUN yum install -y openssl
RUN npm install -g yo generator-hubot
RUN npm install hubot-script-shellcmd
RUN npm uninstall hubot-heroku-keepalive --save
RUN adduser -p `openssl passwd -1 -salt "12345678" hubot` hubot
RUN yum install -y perl-XML-Simple
USER hubot
WORKDIR /home/hubot
ENV HUBOT_OWNER glis
ENV HUBOT_NAME glis-hubotpads
ENV HUBOT_ADAPTER slack
ENV HUBOT_DESCRIPTION Just a friendly robot for GLIS team
RUN yo hubot
RUN rm -f hubot-scripts.json
RUN cp -R node_modules/hubot-script-shellcmd/bash ./
RUN sed -i "s/hubot-redis-brain/hubot-script-shellcmd/g" external-scripts.json
RUN sed -i '/heroku/d' external-scripts.json
EXPOSE 8080
RUN HUBOT_SLACK_TOKEN=xoxb-226655992433-9S2rohyuPqFgf6VfVhQRDHAa ./bin/hubot --adapter slack