ARG HOST_ARCH
ARG IDE

FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 as nvidia
FROM clickable/$HOST_ARCH-16.04-$HOST_ARCH$IDE

LABEL maintainer="Clickable Team"
LABEL Modified by Lukas Baubkus

RUN apt-get update && \
    apt-get install -y --no-install-recommends --force-yes \
        libxau6 \
        libxdmcp6 \
        libxcb1 \
        libxext6 \
        libx11-6 \
        mesa-utils \
        xauth \
        mesa-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=nvidia /usr/local /usr/local
COPY --from=nvidia /etc/ld.so.conf.d/glvnd.conf /etc/ld.so.conf.d/glvnd.conf

ENV NVIDIA_VISIBLE_DEVICES=all NVIDIA_DRIVER_CAPABILITIES=all LANG=C.UTF-8
