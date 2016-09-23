# Base image for django deployments

[![](https://images.microbadger.com/badges/image/logicify/django.svg)](https://microbadger.com/images/logicify/django "Get your own image badge on microbadger.com")

This image is useful if you want to create **production setup** for your django application.
Essentially it runs 2 processes:

* [gunicorn](http://gunicorn.org/) which actually hosts your django aplication
* [Nginx](https://nginx.org/en/) which serves static files and proxies the rest of requests to gunicorn
  
## Requirements

1. You should put you django application code into the following folder of the image: `/srv/application`
1. Static files should be located under `/srv/static`
1. You need to point your application to put media into `/srv/media`. 
1. It is required to pass env variable `APP_MODULE` which contains the name of the module to be used as wsgi entry point.
E.g. `your_app.wsgi`

Ensure you updated your django settings accordingly (especially `MEDIA_ROOT` and `STATIC_ROOT`).
 
## Examples

Here is an example of the Dockerfile which creates an image from the source code (it might be run on CI server 
as a part of build process):

```
FROM logicify/django:1.1

COPY build/code /srv/application
COPY build/static /srv/static

RUN source /srv/virtenv/bin/activate && \
    LANG=en_US.utf8 pip install -r requirements.txt

ENV APP_MODULE "our_app.wsgi"
ENV APP_PROCESS_NAME "our-app-name"

```

So basically what it does is copying files from the build folder into valid locations, setting up all dependencies an 
required variables. As result you have ready to deploy image.

## Supported Variables

* **PROXY_TIMEOUT** - timeout in seconds for nginx proxy (default `90`)
* **STATIC_URL** - url path for static files hosting (default `/static`)
* **STATIC_PATH** - location on the file system where nginx should find static files (`/srv/static`)
* **MEDIA_PATH** - location on the file system where nginx should find media files (`/srv/media`)
