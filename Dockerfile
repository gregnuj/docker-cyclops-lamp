FROM gregnuj/cyclops-lap:alpine3.8
LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
USER root

# Install packages 
RUN set -ex \
    && apk add --no-cache \
    mariadb

# add files in rootfs
ADD ./rootfs /

RUN cd /var/www/html \
    && curl -sS https://www.dbninja.com/download/dbninja.tar.gz | tar xz

WORKDIR /var/www/html
CMD ["/usr/bin/supervisord", "-n"]
