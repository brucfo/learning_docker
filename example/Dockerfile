FROM node:latest
MAINTAINER Bruno Fonseca
ENV ENV=prod
ENV PORT=3000
COPY source destination
WORKDIR /var/www
RUN npm install
ENTRYPOINT npm start
EXPOSE $PORT