FROM amd64/ubuntu:xenial
LABEL maintainer="Clickable Team"
LABEL image_version="2"

# Disable problematic lzma compression - https://blog.packagecloud.io/eng/2016/03/21/apt-hash-sum-mismatch/
RUN echo 'Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/99compression-workaround && \
    echo set debconf/frontend Noninteractive | debconf-communicate && \
    echo set debconf/priority critical | debconf-communicate

# Add ubport repos
RUN echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu xenial main resticted multiverse universe" > /etc/apt/sources.list && \
    echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu xenial-updates main resticted multiverse universe" >> /etc/apt/sources.list && \
    echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu xenial-security main resticted multiverse universe" >> /etc/apt/sources.list && \
    echo "deb [arch=armhf] http://ports.ubuntu.com/ubuntu-ports xenial main resticted multiverse universe" >> /etc/apt/sources.list && \
    echo "deb [arch=armhf] http://ports.ubuntu.com/ubuntu-ports xenial-updates main resticted multiverse universe" >> /etc/apt/sources.list && \
    echo "deb [arch=armhf] http://ports.ubuntu.com/ubuntu-ports xenial-security main restricted multiverse universe" >> /etc/apt/sources.list && \
    # Allow installing armhf packages
    dpkg --add-architecture armhf && \
    # Add other repos
    apt-get update && \
    apt-get -y -f --no-install-recommends install gnupg ubuntu-keyring software-properties-common wget equivs && \
    echo "deb http://repo.ubports.com xenial_-_qt-5-12 main" >> /etc/apt/sources.list && \
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
        g++-arm-linux-gnueabihf \
        crossbuild-essential-armhf \
        gdb-multiarch \
        gdbserver:armhf \
        libc6-dbg:armhf \
        libc-dev:armhf \
        libicu-dev:armhf \
        nodejs \
        pkg-config-arm-linux-gnueabihf \
        qbs \
        qtbase5-private-dev:armhf \
        qtdeclarative5-private-dev:armhf \
        qtfeedback5-dev:armhf \
        qtpositioning5-dev:armhf \
        qtquickcontrols2-5-dev:armhf \
        qtsystems5-dev:armhf \
        qtwebengine5-dev:armhf \
        libqt5opengl5-dev:armhf \
        click \
        click-reviewers-tools \
        ubuntu-sdk-libs-dev:armhf \
        ubuntu-sdk-libs-tools \
        ubuntu-sdk-libs:armhf \
        libconnectivity-qt1-dev:armhf \
        libnotify-dev:armhf \
        libtag1-dev:armhf \
        libsmbclient-dev:armhf \
        libpam0g-dev:armhf \
        python3-requests \
        python3-gnupg \
        && \
    npm install -g cordova@7.0.0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Go env vars
ENV PATH=/usr/local/go/bin/:$PATH

# Install Go
RUN wget https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz && \
    tar -xvf go*.linux-amd64.tar.gz && \
    mv go /usr/local && \
    ln -s /usr/include/arm-linux-gnueabihf/qt5/QtCore/5.9.5/QtCore /usr/include/ && \
    rm go*.linux-amd64.tar.gz

# Rust env vars
ENV CARGO_HOME=/opt/rust/cargo \
    RUSTUP_HOME=/opt/rust/rustup \
    PATH=/opt/rust/cargo/bin:$PATH

# Install Rust
RUN mkdir -p opt/rust && \
    wget https://sh.rustup.rs -O rustup.sh && \
    bash rustup.sh -y --default-toolchain '1.44.1' && \
    rm rustup.sh && \
    rustup target add armv7-unknown-linux-gnueabihf && \
    # Allow the default clickable user to update the registry as well as the git folder
    mkdir -p /opt/rust/cargo/registry && \
    chown -R 1000 /opt/rust/cargo/registry && \
    mkdir -p /opt/rust/cargo/git && \
    chown -R 1000 /opt/rust/cargo/git

# Symlinks to make Rust and Go bindings find Qt includes
RUN ln -s /usr/include/arm-linux-gnueabihf/qt5/QtCore/ /usr/include/QtCore
# Fix default qmake
RUN ln -s $(which qt5-qmake-arm-linux-gnueabihf) /usr/local/bin/qmake

# Ubuntu ships (in Xenial only) a qmake profile for armhf in qt5-qmake, but the
# `ubuntu` prefix confuses QBS; let's rename it, while still keeping the old file
# to avoid breaking older clickable releases:
RUN cp -a /usr/lib/arm-linux-gnueabihf/qt5/mkspecs/ubuntu-arm-gnueabihf-g++ \
       /usr/lib/arm-linux-gnueabihf/qt5/mkspecs/linux-arm-gnueabihf-g++

# QBS setup
RUN qbs setup-toolchains --system --detect && \
    qbs setup-qt --system /usr/local/bin/qmake qt5 && \
    qbs config --system defaultProfile qt5 && \
    qbs config --system profiles.qt5.baseProfile arm-linux-gnueabihf-gcc-5

# TODO see if there is a better location for this
ADD qt.conf /usr/bin/qt.conf
ADD qt.conf /usr/local/bin/qt.conf

# TODO this probably needs to be fixed upstream
ADD ubuntu-click-tools.prf /usr/lib/arm-linux-gnueabihf/qt5/mkspecs/features/ubuntu-click-tools.prf

# Add clickabe compatibility version file
ADD image_version /image_version

# Generated from `dpkg-architecture -a armhf`
ENV DEB_BUILD_ARCH=amd64 \
    DEB_BUILD_ARCH_BITS=64 \
    DEB_BUILD_ARCH_CPU=amd64 \
    DEB_BUILD_ARCH_ENDIAN=little \
    DEB_BUILD_ARCH_OS=linux \
    DEB_BUILD_GNU_CPU=x86_64 \
    DEB_BUILD_GNU_SYSTEM=linux-gnu \
    DEB_BUILD_GNU_TYPE=x86_64-linux-gnu \
    DEB_BUILD_MULTIARCH=x86_64-linux-gnu \
    DEB_HOST_ARCH=armhf \
    DEB_HOST_ARCH_BITS=32 \
    DEB_HOST_ARCH_CPU=arm \
    DEB_HOST_ARCH_ENDIAN=little \
    DEB_HOST_ARCH_OS=linux \
    DEB_HOST_GNU_CPU=arm \
    DEB_HOST_GNU_SYSTEM=linux-gnueabihf \
    DEB_HOST_GNU_TYPE=arm-linux-gnueabihf \
    DEB_HOST_MULTIARCH=arm-linux-gnueabihf \
    DEB_TARGET_ARCH=armhf \
    DEB_TARGET_ARCH_BITS=32 \
    DEB_TARGET_ARCH_CPU=arm \
    DEB_TARGET_ARCH_ENDIAN=little \
    DEB_TARGET_ARCH_OS=linux \
    DEB_TARGET_GNU_CPU=arm \
    DEB_TARGET_GNU_SYSTEM=linux-gnueabihf \
    DEB_TARGET_GNU_TYPE=arm-linux-gnueabihf \
    DEB_TARGET_MULTIARCH=arm-linux-gnueabihf \
    # Env vars for Go cross compile
    GOOS=linux \
    GOARCH=arm \
    GOARM=7 \
    CGO_ENABLED=1 \
    PKG_CONFIG_LIBDIR=/usr/lib/arm-linux-gnueabihf/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig \
    CC=arm-linux-gnueabihf-gcc \
    CXX=arm-linux-gnueabihf-g++
