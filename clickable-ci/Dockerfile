FROM ubuntu:focal
LABEL maintainer="Brian Douglass"

RUN apt-get update && \
    apt-get -y --force-yes install python3-pip && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade setuptools wheel twine flake8 pylint
