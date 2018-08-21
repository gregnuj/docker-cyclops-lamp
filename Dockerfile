FROM gregnuj/cyclops-lap:alpine3.8
LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
USER root

# Install packages 
RUN set -ex \
    && apk add --no-cache \
    mariadb \
    mariadb-client

# add files in rootfs 
COPY --from=gregnuj/cyclops-mariadb:latest /etc/entrypoint.d/* /etc/entrypoint.d/
COPY --from=gregnuj/cyclops-mariadb:latest /etc/supervisor.d/* /etc/supervisor.d/

VOLUME ["/var/lib/mysql"]
WORKDIR /var/www/html
EXPOSE 22 80 443 3360
CMD ["/usr/bin/supervisord", "-n"]
