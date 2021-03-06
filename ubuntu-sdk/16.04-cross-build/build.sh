#!/bin/bash

set -Eeou pipefail

HOST_ARCH=${HOST_ARCH:-amd64}
TARGET_ARCH=${TARGET_ARCH:-armhf}
TAG=${TAG:-latest}

if [ $TARGET_ARCH = "armhf" ]; then
    TARGET_ARCH_TRIPLET=arm-linux-gnueabihf
    RUST_ARCH=armv7-unknown-linux-gnueabihf
    TARGET_CPU=arm
    TARGET_ARCH_BITS=32
elif [ $TARGET_ARCH = "arm64" ]; then
    TARGET_ARCH_TRIPLET=aarch64-linux-gnu
    RUST_ARCH=aarch64-unknown-linux-gnu
    TARGET_CPU=arm64
    TARGET_ARCH_BITS=64
else
    echo "Unsupported TARGET_ARCH: $TARGET_ARCH"
    exit 1
fi

docker build -t clickable/$HOST_ARCH-16.04-$TARGET_ARCH:$TAG \
    --build-arg TARGET_ARCH=$TARGET_ARCH \
    --build-arg HOST_ARCH=$HOST_ARCH \
    --build-arg TARGET_ARCH_TRIPLET=$TARGET_ARCH_TRIPLET \
    --build-arg RUST_ARCH=$RUST_ARCH \
    --build-arg TARGET_CPU=$TARGET_CPU \
    .
