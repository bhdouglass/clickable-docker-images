FROM clickable/ci-16.04-amd64
LABEL maintainer="Brian Douglass"

RUN apt-get update && \
    apt-get -y --force-yes install python3-pip && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade nose coverage cookiecutter setuptools wheel twine
