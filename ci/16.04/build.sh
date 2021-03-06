#!/bin/bash

TARGET_ARCH=${TARGET_ARCH:-armhf}
TAG=${TAG:-latest}
TARGET_TAG=${TARGET_TAG:-latest}

docker build -t clickable/ci-16.04-$TARGET_ARCH:$TAG \
    --build-arg TARGET_ARCH=$TARGET_ARCH \
    .
