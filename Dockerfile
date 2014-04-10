FROM dockerfile/ubuntu
MAINTAINER Kyle Mathews "mathews.kyle@gmail.com"

# Install Nginx.
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -y nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN sed -i 's/user www-data/user root/g' /etc/nginx/nginx.conf

RUN mkdir /etc/nginx/ssl
ADD default /etc/nginx/sites-available/default
ADD default-ssl /etc/nginx/sites-available/default-ssl

EXPOSE 80

CMD ["nginx"]

