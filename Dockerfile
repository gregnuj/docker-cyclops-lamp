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

# add files in rootfs (Note: copying dir overwrites existing)
COPY --from=gregnuj/cyclops-mariadb:stretch /etc/supervisor.d/mariadb.ini /etc/supervisor.d/mariadb.ini
COPY --from=gregnuj/cyclops-mariadb:stretch /etc/entrypoint.d/mariadb-setup.sh /etc/entrypoint.d/mariadb-setup.sh

VOLUME ["/var/lib/mysql"]
WORKDIR /var/www/html
EXPOSE 22 80 443 3360
CMD ["/usr/bin/supervisord", "-n"]
