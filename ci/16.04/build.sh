#!/bin/bash

ARCH=${ARCH:-armhf}
TAG=${TAG:-latest}

docker build -t clickable/ci-16.04-$ARCH:$TAG --build-arg ARCH=$ARCH . $@
