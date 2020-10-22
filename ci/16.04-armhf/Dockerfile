FROM clickable/amd64-16.04-armhf
LABEL maintainer="Clickable Team"

ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

ADD ./install.sh /tmp/install.sh
RUN /tmp/install.sh && rm /tmp/install.sh

ENV CLICKABLE_CONTAINER_MODE=1 \
    CLICKABLE_ARCH=armhf \
    CLICKABLE_NON_INTERACTIVE=1
