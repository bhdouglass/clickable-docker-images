FROM arm64v8/ubuntu:xenial
LABEL maintainer="Clickable Team"
LABEL image_version="4"

COPY qemu-aarch64-static /usr/bin

# Disable problematic lzma compression - https://blog.packagecloud.io/eng/2016/03/21/apt-hash-sum-mismatch/
RUN echo 'Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/99compression-workaround && \
    echo set debconf/frontend Noninteractive | debconf-communicate && \
    echo set debconf/priority critical | debconf-communicate

# Add ubport repos
RUN echo "deb [arch=arm64] http://ports.ubuntu.com/ubuntu-ports xenial main resticted multiverse universe" >> /etc/apt/sources.list && \
    echo "deb [arch=arm64] http://ports.ubuntu.com/ubuntu-ports xenial-updates main resticted multiverse universe" >> /etc/apt/sources.list && \
    echo "deb [arch=arm64] http://ports.ubuntu.com/ubuntu-ports xenial-security main restricted multiverse universe" >> /etc/apt/sources.list && \
    # Add other repos
    apt-get update && \
    apt-get -y -f --no-install-recommends install gnupg ubuntu-keyring software-properties-common wget equivs && \
    echo "deb http://repo.ubports.com xenial main" >> /etc/apt/sources.list && \
    wget -qO - http://repo.ubports.com/keyring.gpg | apt-key add - && \
    wget -qO- https://deb.nodesource.com/setup_10.x | bash - && \
    add-apt-repository ppa:bhdouglass/clickable && \
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
        git \
        g++ \
        libc-dev \
        libicu-dev \
        nodejs \
        pkg-config \
        qtbase5-private-dev \
        qtdeclarative5-private-dev \
        qtfeedback5-dev \
        qtpositioning5-dev \
        qtquickcontrols2-5-dev \
        qtsystems5-dev \
        qtwebengine5-dev \
        libqt5opengl5-dev \
        click \
        click-reviewers-tools \
        ubuntu-sdk-libs-dev \
        ubuntu-sdk-libs-tools \
        ubuntu-sdk-libs \
        libconnectivity-qt1-dev \
        libnotify-dev \
        libtag1-dev \
        libsmbclient-dev \
        libpam0g-dev \
        python3-requests \
        python3-gnupg \
        && \
    npm install -g cordova@7.0.0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Go
RUN wget https://dl.google.com/go/go1.14.2.linux-arm64.tar.gz && \
    tar -xvf go*.linux-arm64.tar.gz && \
    mv go /usr/local && \
    rm go*.linux-arm64.tar.gz

# Rust env vars
ENV CARGO_HOME=/opt/rust/cargo \
    RUSTUP_HOME=/opt/rust/rustup \
    PATH=/opt/rust/cargo/bin:$PATH

# Install Rust
RUN mkdir -p opt/rust && \
    wget https://sh.rustup.rs -O rustup.sh && \
    bash rustup.sh -y --default-toolchain '1.36.0' && \
    rm rustup.sh && \
    rustup target add aarch64-unknown-linux-gnu && \
    # Allow the default clickable user to update the registry as well as the git folder
    mkdir -p /opt/rust/cargo/registry && \
    chown -R 1000 /opt/rust/cargo/registry && \
    mkdir -p /opt/rust/cargo/git && \
    chown -R 1000 /opt/rust/cargo/git

# Symlinks to make Rust and Go bindings find Qt includes
RUN ln -s /usr/include/aarch64-linux-gnu/qt5/QtCore/ /usr/include/QtCore

# Fix default qmake (suprisingly this works for arm64, too)
RUN ln -s $(which qt5-qmake-arm-linux-gnueabihf) /usr/local/bin/qmake

# TODO see if there is a better location for this
ADD qt.conf /usr/bin/qt.conf
ADD qt.conf /usr/local/bin/qt.conf

# TODO this probably needs to be fixed upstream
ADD ubuntu-click-tools.prf /usr/lib/aarch64-linux-gnu/qt5/mkspecs/features/ubuntu-click-tools.prf

# Add clickabe compatibility version file
ADD image_version /image_version

# Generated from `dpkg-architecture -a arm64`
ENV DEB_BUILD_ARCH=arm64 \
    DEB_BUILD_ARCH_BITS=64 \
    DEB_BUILD_ARCH_CPU=arm64 \
    DEB_BUILD_ARCH_ENDIAN=little \
    DEB_BUILD_ARCH_OS=linux \
    DEB_BUILD_GNU_CPU=aarch64 \
    DEB_BUILD_GNU_SYSTEM=linux-gnu \
    DEB_BUILD_GNU_TYPE=aarch64-linux-gnu \
    DEB_BUILD_MULTIARCH=aarch64-linux-gnu \
    DEB_HOST_ARCH=arm64 \
    DEB_HOST_ARCH_BITS=64 \
    DEB_HOST_ARCH_CPU=arm64 \
    DEB_HOST_ARCH_ENDIAN=little \
    DEB_HOST_ARCH_OS=linux \
    DEB_HOST_GNU_CPU=aarch64 \
    DEB_HOST_GNU_SYSTEM=linux-gnu \
    DEB_HOST_GNU_TYPE=aarch64-linux-gnu \
    DEB_HOST_MULTIARCH=aarch64-linux-gnu \
    DEB_TARGET_ARCH=arm64 \
    DEB_TARGET_ARCH_BITS=64 \
    DEB_TARGET_ARCH_CPU=arm64 \
    DEB_TARGET_ARCH_ENDIAN=little \
    DEB_TARGET_ARCH_OS=linux \
    DEB_TARGET_GNU_CPU=aarch64 \
    DEB_TARGET_GNU_SYSTEM=linux-gnu \
    DEB_TARGET_GNU_TYPE=aarch64-linux-gnu \
    DEB_TARGET_MULTIARCH=aarch64-linux-gnu \
    # Env vars for Go cross compile
    GOOS=linux \
    GOARCH=arm64 \
    CGO_ENABLED=1 \
    PKG_CONFIG_LIBDIR=/usr/lib/aarch64-linux-gnu/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig \
    CC=aarch64-linux-gnu-gcc \
    CXX=aarch64-linux-gnu-g++
