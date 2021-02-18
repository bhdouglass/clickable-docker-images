#!/bin/bash

HOST_ARCH=${HOST_ARCH:-amd64}
TAG=${TAG:-16.04.4-qt5.9}

if [ $HOST_ARCH = "armhf" ]; then
    QEMU_USER_STATIC_ARCH=arm
elif [ $HOST_ARCH = "arm64" ]; then
    QEMU_USER_STATIC_ARCH=aarch64
elif [ $HOST_ARCH = "amd64" ]; then
    QEMU_USER_STATIC_ARCH=x86_64
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
    --build-arg HOST_ARCH=$HOST_ARCH \
    .
