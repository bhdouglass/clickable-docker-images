#!/bin/bash

HOST_ARCH=${HOST_ARCH:-amd64}
TAG=${TAG:-latest}
# Set to "-ide" to build the nvidia-ide image
IDE=${IDE:-""}

docker build -t clickable/$HOST_ARCH-16.04-$HOST_ARCH-nvidia$IDE:$TAG \
    --build-arg HOST_ARCH=$HOST_ARCH \
    --build-arg IDE=$IDE \
    .
