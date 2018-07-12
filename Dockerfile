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

WORKDIR /var/www
CMD ["/usr/bin/supervisord", "-n"]
