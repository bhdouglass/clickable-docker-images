FROM clickable/ubuntu-sdk:16.04-arm64
MAINTAINER Brian Douglass

RUN apt-get update && \
    apt-get -y -f --no-install-recommends install gnupg ubuntu-keyring software-properties-common && \
    add-apt-repository ppa:bhdouglass/clickable && \
    apt-get update && \
    apt-get install -y clickable && \
    apt-get -y remove software-properties-common wget && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV CLICKABLE_CONTAINER_MODE=1
ENV CLICKABLE_ARCH=arm64
