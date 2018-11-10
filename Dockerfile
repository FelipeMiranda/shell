# specify the node base image with your desired version node:<version>
#FROM node:carbon
FROM buildpack-deps:jessie

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)



RUN mkdir /root/shell/node_modules -p
RUN mkdir /root/shell/hostScripts -p
RUN mkdir /root/shell/linux -p
RUN mkdir /root/shell/push -p
RUN mkdir /root/shell/ansible -p
RUN mkdir /root/shell/KRN_SW_ASSET -p
RUN mkdir /root/shell/skeleton -p
RUN mkdir /root/shell/install -p
RUN mkdir /root/shell/openbsd -p
RUN mkdir /root/shell/license -p
RUN mkdir /root/shell/funcoeszz -p
RUN mkdir /root/shell/githooks -p
RUN mkdir /root/shell/github -p


#RUN npm install crawler-js 
COPY push /root/shell/push
COPY linux /root/shell/linux
COPY hostScripts /root/shell/hostScripts 
COPY ansible /root/shell/ansible
COPY skeleton /root/shell/skeleton
COPY install /root/shell/install
COPY openbsd /root/shell/openbsd
COPY license /root/shell/license
COPY funcoeszz /root/shell/funcoeszz
COPY githooks /root/shell/githooks
COPY github /root/shell/github

RUN ln -s /usr/local/bin/node /usr/bin/node
RUN /root/shell/install.sh
RUN find /root


RUN ln -s /usr/src/app/node_modules /root/shell/node_modules

# Bundle app source
COPY . .

CMD [ "node", "/root/shell/push/cdshell.js" ]




######################
#CMD [ "npm", "load" ]
#ENTRYPOINT ["/root/workspace/bolsa-systems/blueMoney/dataMining/mining.sh"]
#RUN ping www.google.com.br
#RUN git clone https://github.com/quirinobytes/workspace.git
#RUN ls -la
#ENTRYPOINT ["node","bolsa.js"]
