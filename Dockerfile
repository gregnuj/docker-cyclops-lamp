FROM gregnuj/cyclops-lap:stretch
LABEL MAINTAINER="Greg Junge <gregnuj@gmail.com>"
USER root

# Install packages 
RUN set -ex \
    && sudo apt-key adv --no-tty --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8 \
    && echo "deb [arch=amd64,i386,ppc64el] http://ftp.osuosl.org/pub/mariadb/repo/10.2/debian stretch main" > /etc/apt/sources.list.d/mariadb.list \
    && apt-get update \
    && apt-get install -y \
    mariadb-server \
    mariadb-client \
    --no-install-recommends \
    && rm -r /var/lib/apt/lists/*

# add files in rootfs (Note: copying dir overwrites existing)
COPY --from=gregnuj/cyclops-mariadb:stretch /etc/supervisor.d/mariadb.ini /etc/supervisor.d/mariadb.ini
COPY --from=gregnuj/cyclops-mariadb:stretch /etc/entrypoint.d/serial/mariadb-setup.sh /etc/entrypoint.d/serial/mariadb-setup.sh
COPY --from=gregnuj/cyclops-mariadb:stretch /usr/local/bin/sync_master.sh /usr/local/bin/sync_master.sh
COPY --from=gregnuj/cyclops-mariadb:stretch /usr/local/bin/check_replication.sh /usr/local/bin/check_replication.sh

EXPOSE 22 80 443 3360 9001
VOLUME ["/var/lib/mysql"]
