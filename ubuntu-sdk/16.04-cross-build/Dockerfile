ARG HOST_ARCH
FROM $HOST_ARCH/ubuntu:xenial

ARG HOST_ARCH
ARG TARGET_ARCH
ARG TARGET_ARCH_TRIPLET
ARG TARGET_CPU
ARG RUST_ARCH
ARG IMAGE_VERSION=4

LABEL maintainer="Clickable Team"
LABEL image_version="$IMAGE_VERSION"

# Disable problematic lzma compression - https://blog.packagecloud.io/eng/2016/03/21/apt-hash-sum-mismatch/
RUN echo 'Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/99compression-workaround && \
    echo set debconf/frontend Noninteractive | debconf-communicate && \
    echo set debconf/priority critical | debconf-communicate

# Add ubport repos
RUN echo "deb [arch=$HOST_ARCH] http://archive.ubuntu.com/ubuntu xenial main resticted multiverse universe" > /etc/apt/sources.list && \
    echo "deb [arch=$HOST_ARCH] http://archive.ubuntu.com/ubuntu xenial-updates main resticted multiverse universe" >> /etc/apt/sources.list && \
    echo "deb [arch=$HOST_ARCH] http://archive.ubuntu.com/ubuntu xenial-security main resticted multiverse universe" >> /etc/apt/sources.list && \
    echo "deb [arch=$TARGET_ARCH] http://ports.ubuntu.com/ubuntu-ports xenial main resticted multiverse universe" >> /etc/apt/sources.list && \
    echo "deb [arch=$TARGET_ARCH] http://ports.ubuntu.com/ubuntu-ports xenial-updates main resticted multiverse universe" >> /etc/apt/sources.list && \
    echo "deb [arch=$TARGET_ARCH] http://ports.ubuntu.com/ubuntu-ports xenial-security main restricted multiverse universe" >> /etc/apt/sources.list && \
    # Allow installing cross-platform packages
    dpkg --add-architecture $TARGET_ARCH && \
    # Add other repos
    apt-get update && \
    apt-get -y -f --no-install-recommends install gnupg ubuntu-keyring software-properties-common wget && \
    echo "deb http://repo.ubports.com xenial main" >> /etc/apt/sources.list && \
    wget -qO - http://repo.ubports.com/keyring.gpg | apt-key add - && \
    wget -qO- https://deb.nodesource.com/setup_12.x | bash - && \
    add-apt-repository ppa:bhdouglass/clickable && \
    add-apt-repository ppa:mardy/qbs-on-lts && \
    # Cleanup
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get update && \
    apt-get -y --no-install-recommends dist-upgrade && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get update && \
    apt-get -y --no-install-recommends install \
    build-essential \
    cmake \
    pkg-config \
    git \
    dpkg-cross \
    g++-$TARGET_ARCH_TRIPLET \
    crossbuild-essential-$TARGET_ARCH \
    gdb-multiarch \
    gdbserver:$TARGET_ARCH \
    libc6-dbg:$TARGET_ARCH \
    libc-dev:$TARGET_ARCH \
    libicu-dev:$TARGET_ARCH \
    nodejs \
    pkg-config-$TARGET_ARCH_TRIPLET \
    qbs \
    qtbase5-private-dev:$TARGET_ARCH \
    qtdeclarative5-private-dev:$TARGET_ARCH \
    qtfeedback5-dev:$TARGET_ARCH \
    qtpositioning5-dev:$TARGET_ARCH \
    qtquickcontrols2-5-dev:$TARGET_ARCH \
    qtsystems5-dev:$TARGET_ARCH \
    qtwebengine5-dev:$TARGET_ARCH \
    libqt5opengl5-dev:$TARGET_ARCH \
    click \
    click-reviewers-tools \
    ubuntu-sdk-libs-dev:$TARGET_ARCH \
    ubuntu-sdk-libs-tools \
    ubuntu-sdk-libs:$TARGET_ARCH \
    libconnectivity-qt1-dev:$TARGET_ARCH \
    libnotify-dev:$TARGET_ARCH \
    libtag1-dev:$TARGET_ARCH \
    libsmbclient-dev:$TARGET_ARCH \
    libpam0g-dev:$TARGET_ARCH \
    python3-requests \
    python3-gnupg \
    && \
    npm install -g cordova@7.0.0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Go env vars
ENV PATH=/usr/local/go/bin/:$PATH

# Install Go
RUN wget https://dl.google.com/go/go1.14.2.linux-$HOST_ARCH.tar.gz && \
    tar -xf go*.linux-$HOST_ARCH.tar.gz && \
    mv go /usr/local && \
    rm go*.linux-$HOST_ARCH.tar.gz

# Rust env vars
ENV CARGO_HOME=/opt/rust/cargo \
    RUSTUP_HOME=/opt/rust/rustup \
    PATH=/opt/rust/cargo/bin:$PATH

# Install Rust
RUN mkdir -p opt/rust && \
    wget https://sh.rustup.rs -O rustup.sh && \
    bash rustup.sh -y --default-toolchain '1.44.1' && \
    rm rustup.sh && \
    rustup target add $RUST_ARCH && \
    # Allow the default clickable user to update the registry as well as the git folder
    mkdir -p /opt/rust/cargo/registry && \
    chown -R 1000 /opt/rust/cargo/registry && \
    mkdir -p /opt/rust/cargo/git && \
    chown -R 1000 /opt/rust/cargo/git

# Symlinks to make Rust and Go bindings find Qt includes
RUN ln -s /usr/include/$TARGET_ARCH_TRIPLET/qt5/QtCore/ /usr/include/QtCore
# Fix default qmake (suprisingly this works for arm64, too)
RUN ln -s $(which qt5-qmake-arm-linux-gnueabihf) /usr/local/bin/qmake

# QBS setup
RUN qbs setup-toolchains --system --detect && \
    qbs setup-qt --system /usr/local/bin/qmake qt5 && \
    qbs config --system defaultProfile qt5 && \
    qbs config --system profiles.qt5.baseProfile $TARGET_ARCH_TRIPLET-gcc-5

# TODO see if there is a better location for this
ADD qt-$TARGET_ARCH.conf /usr/bin/qt.conf
ADD qt-$TARGET_ARCH.conf /usr/local/bin/qt.conf

# TODO this probably needs to be fixed upstream
ADD ubuntu-click-tools.prf /usr/lib/$TARGET_ARCH_TRIPLET/qt5/mkspecs/features/ubuntu-click-tools.prf

# Add clickabe compatibility version file
RUN echo $IMAGE_VERSION > /image_version

# Fix Rust and Go qmake access
RUN ln -sf /usr/lib/$TARGET_ARCH_TRIPLET/qt5/bin/qmake /usr/local/bin/qmake

# Generated from `dpkg-architecture -a armhf`
ENV DEB_BUILD_ARCH=amd64 \
    DEB_BUILD_ARCH_BITS=64 \
    DEB_BUILD_ARCH_CPU=amd64 \
    DEB_BUILD_ARCH_ENDIAN=little \
    DEB_BUILD_ARCH_OS=linux \
    DEB_BUILD_GNU_CPU=x86_64 \
    DEB_BUILD_GNU_SYSTEM=linux-gnu \
    DEB_BUILD_GNU_TYPE=x86_64-linux-gnu \
    DEB_BUILD_MULTIARCH=. \
    DEB_HOST_ARCH=$TARGET_ARCH \
    DEB_HOST_ARCH_BITS=$TARGET_ARCH_BITS \
    DEB_HOST_ARCH_CPU=$TARGET_CPU \
    DEB_HOST_ARCH_ENDIAN=little \
    DEB_HOST_ARCH_OS=linux \
    DEB_HOST_GNU_CPU=$TARGET_CPU \
    DEB_HOST_GNU_SYSTEM=linux-gnueabihf \
    DEB_HOST_GNU_TYPE=$TARGET_ARCH_TRIPLET \
    DEB_HOST_MULTIARCH=$TARGET_ARCH_TRIPLET \
    DEB_TARGET_ARCH=$TARGET_ARCH \
    DEB_TARGET_ARCH_BITS=$TARGET_ARCH_BITS \
    DEB_TARGET_ARCH_CPU=$TARGET_CPU \
    DEB_TARGET_ARCH_ENDIAN=little \
    DEB_TARGET_ARCH_OS=linux \
    DEB_TARGET_GNU_CPU=$TARGET_CPU \
    DEB_TARGET_GNU_SYSTEM=linux-gnueabihf \
    DEB_TARGET_GNU_TYPE=$TARGET_ARCH_TRIPLET \
    DEB_TARGET_MULTIARCH=$TARGET_ARCH_TRIPLET \
    # Env vars for Go cross compile
    GOOS=linux \
    GOARCH=$TARGET_CPU \
    CGO_ENABLED=1 \
    PKG_CONFIG_LIBDIR=/usr/lib/$TARGET_ARCH_TRIPLET/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig \
    CC=$TARGET_ARCH_TRIPLET-gcc \
    CXX=$TARGET_ARCH_TRIPLET-g++
