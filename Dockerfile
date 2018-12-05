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
COPY --from=gregnuj/cyclops-mariadb:latest /usr/local/bin/sync_master.sh /usr/local/bin/sync_master.sh
COPY --from=gregnuj/cyclops-mariadb:latest /usr/local/bin/check_replication.sh /usr/local/bin/check_replication.sh

EXPOSE 22 80 443 3360 9001
VOLUME ["/var/lib/mysql"]
