#!/bin/bash

set -eou pipefail

HOST_ARCH=${HOST_ARCH:-amd64}
TAG=${TAG:-latest}

if [ $HOST_ARCH = "armhf" ]; then
    HOST_ARCH_TRIPLET=arm-linux-gnueabihf
    HOST_ARCH_BASE=armhf
    QEMU_USER_STATIC_ARCH=arm
    DEB_URL=http://ports.ubuntu.com/ubuntu-ports
    QBS_SUPPORT=
    GO_ARCH=armv6l
elif [ $HOST_ARCH = "arm64" ]; then
    HOST_ARCH_TRIPLET=aarch64-linux-gnu
    HOST_ARCH_BASE=arm64v8
    QEMU_USER_STATIC_ARCH=aarch64
    DEB_URL=http://ports.ubuntu.com/ubuntu-ports
    QBS_SUPPORT=
    GO_ARCH=arm64
elif [ $HOST_ARCH = "amd64" ]; then
    HOST_ARCH_TRIPLET=x86_64-linux-gnu
    HOST_ARCH_BASE=amd64
    QEMU_USER_STATIC_ARCH=x86_64
    DEB_URL=http://archive.ubuntu.com/ubuntu
    QBS_SUPPORT=qbs
    GO_ARCH=amd64
else
    echo "Unsupported HOST_ARCH: $HOST_ARCH"
    exit 1
fi

# Reference: https://stackoverflow.com/a/54595564/6640061
QEMU_USER_STATIC_DOWNLOAD_URL="https://github.com/multiarch/qemu-user-static/releases/download"
QEMU_USER_STATIC_LATEST_TAG=$(curl -s https://api.github.com/repos/multiarch/qemu-user-static/tags \
    | grep 'name.*v[0-9]' \
    | head -n 1 \
    | cut -d '"' -f 4)

curl -SL "${QEMU_USER_STATIC_DOWNLOAD_URL}/${QEMU_USER_STATIC_LATEST_TAG}/x86_64_qemu-${QEMU_USER_STATIC_ARCH}-static.tar.gz" \
    | tar xzv

docker run --rm --privileged multiarch/qemu-user-static:register --reset

docker build -t clickable/$HOST_ARCH-16.04-$HOST_ARCH:$TAG \
    --build-arg HOST_ARCH_TRIPLET=$HOST_ARCH_TRIPLET \
    --build-arg HOST_ARCH=$HOST_ARCH \
    --build-arg HOST_ARCH_BASE=$HOST_ARCH_BASE \
    --build-arg QEMU_USER_STATIC_ARCH=$QEMU_USER_STATIC_ARCH \
    --build-arg DEB_URL=$DEB_URL \
    --build-arg QBS_SUPPORT=$QBS_SUPPORT \
    --build-arg GO_ARCH=$GO_ARCH \
    .
