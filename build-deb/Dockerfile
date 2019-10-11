FROM ubuntu:bionic
LABEL maintainer="Brian Douglass"

RUN echo set debconf/frontend Noninteractive | debconf-communicate && \
    echo set debconf/priority critical | debconf-communicate

RUN apt-get update && \
    apt-get -y --force-yes install \
        debhelper \
        help2man \
        dpkg-dev \
        python3 \
        python3-stdeb \
        python3-cookiecutter \
        python3-ipdb \
        python3-jsonschema \
        fakeroot \
        build-essential \
        devscripts \
        && \
    apt-get clean
