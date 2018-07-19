FROM gregnuj/cyclops-lap:stretch
LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
USER root

# Install packages 
RUN set -ex \
    && apt-get update \
    && apt-get install -y \
    mariadb-server \
    mariadb-client \
    --no-install-recommends \
    && rm -r /var/lib/apt/lists/*

# add files in rootfs
ADD ./rootfs /

RUN cd /var/www/html \
    && curl -sS https://www.dbninja.com/download/dbninja.tar.gz | tar xz

WORKDIR /var/www/html
EXPOSE 22 80 443 3360
CMD ["/usr/bin/supervisord", "-n"]
