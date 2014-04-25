# version 12.10
FROM dockerfile/ubuntu
MAINTAINER Kyle Mathews "mathews.kyle@gmail.com"

# Install Nginx.
ADD nginx_signing.key /tmp/nginx_signing.key
RUN apt-key add /tmp/nginx_signing.key
RUN echo "deb http://nginx.org/packages/ubuntu/ quantal nginx\n deb-src http://nginx.org/packages/ubuntu/ quantal nginx" | tee /etc/apt/sources.list.d/nginx.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nginx=1.6.0-1~quantal
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN sed -i 's/user www-data/user root/g' /etc/nginx/nginx.conf

RUN mkdir /etc/nginx/ssl
ADD default /etc/nginx/sites-available/default
ADD default-ssl /etc/nginx/sites-available/default-ssl

EXPOSE 80

CMD ["nginx"]

