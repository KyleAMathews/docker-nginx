docker-nginx
============

A high-performance Nginx base image for Docker to serve static websites. It will serve anything in the `/var/www` directory.

To build a Docker image for your site, you'll need to create a `Dockerfile`. For example, if your site is in a directory called `src/`, you could create this `Dockerfile`:

    FROM kyma/docker-nginx
    COPY src/ /var/www
    CMD 'nginx'

Then build and run it:

    $ docker build -t mysite .
    ...
    Successfully built 5ae2fb5cf4f8
    $ docker run -p 80:80 -d mysite
    da809981545f
    $ curl localhost
    ...

Docker Hub
----------
The trusted build information can be found on the Docker Hub at https://registry.hub.docker.com/u/kyma/docker-nginx/.

SSL
---

To use SSL, put your certs in `/etc/nginx/ssl` and enable the `default-ssl` site:

    ADD server.crt /etc/nginx/ssl/
    ADD server.key /etc/nginx/ssl/
    RUN ln -s /etc/nginx/sites-available/default-ssl /etc/nginx/sites-enabled/default-ssl

When you run it, you'll want to make port 443 available, e.g.:

    $ docker run -p 80:80 -p 443:443 -d mysite


nginx.conf
---------

The nginx.conf and mime.types are pulled with slight modifications from
the h5bp Nginx HTTP server boilerplate configs project at
https://github.com/h5bp/server-configs-nginx

Customized configs
------------------

To modify the NGINX config, you would just create a custom Dockerfile like the following
where you copy in your modified config files.

```dockerfile
# Guide here:
# https://github.com/KyleAMathews/docker-nginx

# Build docker file
# docker build -t CONTAINERNAME .

# Build from this repo's image
FROM kyma/docker-nginx

# Example if you wanna swap the default server file.
COPY path/to/your/default /etc/nginx/sites-enabled/default

# Add src.
COPY src/ /var/www

CMD 'nginx'
```
