FROM gregnuj/cyclops-lap:latest
LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
USER root

# Install packages 
RUN set -ex \
    && apk add --no-cache \
    mariadb \
    mariadb-client

# add files in rootfs (Note: copying dir overwrites existing)
COPY --from=gregnuj/cyclops-mariadb:latest /etc/supervisor.d/mariadb.ini /etc/supervisor.d/mariadb.ini
COPY --from=gregnuj/cyclops-mariadb:latest /etc/entrypoint.d/serial/mariadb-setup.sh /etc/entrypoint.d/serial/mariadb-setup.sh

EXPOSE 22 80 443 3360 9001
VOLUME ["/var/lib/mysql"]
WORKDIR "/var/www/html"
CMD ["/usr/bin/supervisord", "-n"]
