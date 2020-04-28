FROM ubuntu:xenial
LABEL maintainer="Brian Douglass"

RUN echo set debconf/frontend Noninteractive | debconf-communicate && \
    echo set debconf/priority critical | debconf-communicate

RUN apt-get update && \
    apt-get -y --force-yes install \
        debhelper \
        dh-python \
        help2man \
        dpkg-dev \
        fakeroot \
        build-essential \
        devscripts \
        python3 \
        python3-requests \
        python3-setuptools \
        python3-cookiecutter \
        python3-jsonschema \
        fakeroot \
        build-essential \
        devscripts \
        && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
