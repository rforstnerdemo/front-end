#FROM node:10-alpine
FROM node:latest
ENV NODE_ENV "production"
ENV PORT 8080
EXPOSE 8080
RUN addgroup mygroup && adduser --group mygroup myuser && mkdir -p /usr/src/app && chown -R myuser /usr/src/app
#RUN addgroup mygroup && adduser -D -G mygroup myuser && mkdir -p /usr/src/app && chown -R myuser /usr/src/app

# Prepare app directory
WORKDIR /usr/src/app
COPY package.json /usr/src/app/
COPY yarn.lock /usr/src/app/
RUN chown myuser /usr/src/app/yarn.lock

USER myuser

RUN node -e 'const os = require("os"); const interfaces = os.networkInterfaces(); for (const interface in interfaces) {console.log(interface); const addrs = interfaces[interface]; for (const addr of addrs) {console.log(addr.address)}}'
RUN yarn install
#RUN apk --update add --no-cache yarn
COPY . /usr/src/app

# Start the app
#CMD ["/usr/local/bin/npm", "start", "--domain=.jx-staging.35.241.184.104.nip.io"] 
CMD ["/usr/local/bin/npm", "start"]
