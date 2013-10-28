FROM ubuntu:12.04
MAINTAINER Ben Firshman "ben@orchardup.com"
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install nginx

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD default /etc/nginx/sites-available/default

EXPOSE 80

CMD ["nginx"]

