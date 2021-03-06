FROM ubuntu:bionic
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
        python3-setuptools \
        python3-requests \
        python3-cookiecutter \
        python3-jsonschema \
        fakeroot \
        build-essential \
        devscripts \
        python3-all \
        python3-sphinx \
        python3-sphinx-rtd-theme \
        python3-mock \
        python3-pytest \
        python3-pytest-mock \
        python3-pytest-cov \
        python3-freezegun \
        && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
