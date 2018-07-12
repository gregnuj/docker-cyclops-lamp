FROM gregnuj/cyclops-lap:edge
LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
USER root

# Install packages 
RUN set -ex \
    && apk add --no-cache \
    mariadb

# add files in rootfs
ADD ./rootfs /

WORKDIR /var/www/html
CMD ["/usr/bin/supervisord", "-n"]
