FROM gregnuj/cyclops-lap:edge
LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
USER root

# Install packages 
RUN set -ex \
    && apk add --no-cache \
    mariadb

# add files in rootfs
ADD ./rootfs /

VOLUME ["/var/lib/mysql"]
WORKDIR /var/www/html
EXPOSE 22 80 443 3360
CMD ["/usr/bin/supervisord", "-n"]
