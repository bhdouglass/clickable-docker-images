ARG TARGET_ARCH
FROM clickable/amd64-16.04-$TARGET_ARCH:$TARGET_TAG

# Needs to be defined before and after because they are different stages
ARG TARGET_ARCH
LABEL maintainer="Clickable Team"

ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y -f --no-install-recommends install gnupg ubuntu-keyring software-properties-common && \
    add-apt-repository ppa:bhdouglass/clickable && \
    apt-get update && \
    apt-get install -y clickable locales-all && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


ENV CLICKABLE_CONTAINER_MODE=1 \
    CLICKABLE_ARCH=$TARGET_ARCH \
    CLICKABLE_NON_INTERACTIVE=1
