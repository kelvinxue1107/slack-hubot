# Version 0.3
FROM centos:latest
MAINTAINER kelvin.xue@outlook.com/citrix.com
RUN yum install -y gcc-c++ make
RUN curl -sL https://rpm.nodesource.com/setup_8.x | bash
RUN yum install -y nodejs openssl perl-XML-Simple
RUN yum install -y OpenIPMI OpenIPMI-tools
RUN npm install -g yo generator-hubot
RUN npm uninstall hubot-heroku-keepalive --save
RUN adduser -p `openssl passwd -1 -salt "12345678" hubot` hubot
USER hubot
WORKDIR /home/hubot
RUN yo hubot --owner="kelvin.xue" --name="YOURNAME" --description="hubots" --defaults
RUN npm install hubot-script-shellcmd
RUN npm install hubot-slack
RUN rm -f hubot-scripts.json && cp -R node_modules/hubot-script-shellcmd/bash ./
RUN sed -i "s/hubot-redis-brain/hubot-script-shellcmd/g" external-scripts.json && sed -i '/heroku/d' external-scripts.json
RUN chkconfig ipmi on
RUN service ipmi start
EXPOSE 8080
EXPOSE 623
RUN HUBOT_SLACK_TOKEN=#yourtoken ./bin/hubot --adapter slack
