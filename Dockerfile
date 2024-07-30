FROM webdevops/php-nginx:7.3

# Disable or remove the nginx repository to avoid expired key issues
RUN rm -f /etc/apt/sources.list.d/nginx.list && \
    sed -i '/nginx.org/d' /etc/apt/sources.list && \
    apt-key del ABF5BD827BD9BF62

# Update package lists and upgrade all packages
RUN apt-get clean && \
    apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install sudo libpq-dev libsodium-dev libmagickwand-dev libmagickcore-dev libgmp-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install latest versions of specific vulnerable packages
RUN apt-get clean && \
    apt-get -y update && \
    apt-get -y install git vim curl linux-image-amd64 openssl imagemagick && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo > /opt/docker/bin/service.d/dnsmasq.d/10-init.sh && \
    echo > /opt/docker/etc/supervisor.d/dnsmasq.conf && \
    echo > /opt/docker/bin/service.d/dnsmasq.sh

RUN docker-php-ext-install pgsql pdo_pgsql gmp && \
    pecl install -f xhprof-2.1.4 libsodium-2.0.7 mongodb-1.7.4 && \
    docker-php-ext-enable imagick && \
    docker-php-ext-enable sodium && \
    docker-php-ext-enable xhprof

ENV FPM_MAX_REQUESTS 200
ENV FPM_REQUEST_TERMINATE_TIMEOUT 60s
