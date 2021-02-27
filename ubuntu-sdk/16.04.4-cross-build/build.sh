#!/bin/bash

set -Eeou pipefail

HOST_ARCH=${HOST_ARCH:-amd64}
TARGET_ARCH=${TARGET_ARCH:-armhf}
TAG=${TAG:-16.04.4-qt5.9}

docker build -t clickable/$HOST_ARCH-16.04-$TARGET_ARCH:$TAG \
    --build-arg TARGET_ARCH=$TARGET_ARCH \
    --build-arg HOST_ARCH=$HOST_ARCH \
    .
