# version 14.04
FROM dockerfile/ubuntu
MAINTAINER Kyle Mathews "mathews.kyle@gmail.com"

# Install Nginx.
ADD nginx_signing.key /tmp/nginx_signing.key
RUN apt-key add /tmp/nginx_signing.key
RUN echo "deb http://nginx.org/packages/ubuntu/ $(lsb_release -cs) nginx\n deb-src http://nginx.org/packages/ubuntu/ $(lsb_release -cs) nginx" | tee /etc/apt/sources.list.d/nginx.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nginx=1.6.1-1~$(lsb_release -cs)

RUN rm /etc/nginx/nginx.conf /etc/nginx/mime.types
ADD nginx.conf /etc/nginx/nginx.conf
ADD mime.types /etc/nginx/mime.types
RUN mkdir /etc/nginx/ssl
ADD default /etc/nginx/sites-enabled/default
ADD default-ssl /etc/nginx/sites-available/default-ssl

# expose both the HTTP (80) and HTTPS (443) ports
EXPOSE 80 443

CMD ["nginx"]

