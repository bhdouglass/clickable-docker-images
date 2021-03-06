#!/bin/bash

HOST_ARCH=${HOST_ARCH:-amd64}
TAG=${TAG:-latest}

docker build -t clickable/$HOST_ARCH-16.04-$HOST_ARCH-ide:$TAG \
    --build-arg HOST_ARCH=$HOST_ARCH \
    .
