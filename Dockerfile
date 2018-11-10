# specify the node base image with your desired version node:<version>
FROM node:carbon
#FROM buildpack-deps:jessie

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
RUN mkdir /root/.ssh -p


#RUN npm install crawler-js 
COPY push/. push/.
COPY linux/. /root/shell/linux/.
COPY linux/. linux/.
COPY hostScripts /root/shell/hostScripts 
COPY ansible /root/shell/ansible
COPY skeleton /root/shell/skeleton
COPY install /root/shell/install
COPY openbsd /root/shell/openbsd
COPY license /root/shell/license
COPY funcoeszz /root/shell/funcoeszz
COPY githooks /root/shell/githooks
COPY github /root/shell/github
COPY . .
COPY . /root/shell/
COPY .bashrc /root/
COPY .alias /root/
COPY .export /root/
COPY secret/id_rsa /root/.ssh/
RUN chmod 600 /root/.ssh/id_rsa

RUN ln -s /usr/src/app/node_modules /root/shell/node_modules
RUN ln -s /usr/local/bin/nodejs /usr/bin/node


CMD [ "/bin/sh", "/root/shell/install.sh" ]
#CMD [ "node", "/usr/src/app/push/cdshelld.js" ]
ENTRYPOINT [ "/root/shell/container_init.sh" ]




######################
#CMD [ "npm", "load" ]
#ENTRYPOINT ["/root/workspace/bolsa-systems/blueMoney/dataMining/mining.sh"]
#RUN ping www.google.com.br
#RUN git clone https://github.com/quirinobytes/workspace.git
#RUN ls -la
##ENTRYPOINT ["node","bolsa.js"]
