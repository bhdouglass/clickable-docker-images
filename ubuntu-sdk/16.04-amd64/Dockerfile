FROM ubuntu:xenial
LABEL maintainer="Brian Douglass"

# Disable problematic lzma compression - https://blog.packagecloud.io/eng/2016/03/21/apt-hash-sum-mismatch/
RUN echo 'Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/99compression-workaround && \
    echo set debconf/frontend Noninteractive | debconf-communicate && \
    echo set debconf/priority critical | debconf-communicate

# Add ubport repos
RUN echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu xenial main resticted multiverse universe" > /etc/apt/sources.list && \
    echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu xenial-updates main resticted multiverse universe" >> /etc/apt/sources.list && \
    echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu xenial-security main resticted multiverse universe" >> /etc/apt/sources.list && \
    # Add other repos
    apt-get update && \
    apt-get -y -f --no-install-recommends install gnupg ubuntu-keyring software-properties-common wget && \
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
        libc-dev \
        libicu-dev \
        isc-dhcp-client \
        nodejs \
        qtbase5-private-dev \
        qtdeclarative5-private-dev \
        qtfeedback5-dev \
        qtpositioning5-dev \
        qtquickcontrols2-5-dev \
        qtsystems5-dev \
        qtwebengine5-dev \
        libqt5opengl5-dev \
        language-pack-en \
        click \
        click-reviewers-tools \
        morph-webapp-container \
        ubuntu-sdk-libs \
        ubuntu-sdk-libs-dev \
        ubuntu-sdk-libs-tools \
        qml-module-io-thp-pyotherside \
        qml-module-ubuntu-connectivity \
        qml-module-ubuntu-thumbnailer0.1 \
        libconnectivity-qt1-dev \
        libnotify-dev \
        libtag1-dev \
        libsmbclient-dev \
        libpam0g-dev \
        python3-requests \
        python3-gnupg \
        xvfb \
        gdb \
        gdbserver \
        gstreamer1.0-plugins-good \
        gstreamer1.0-plugins-bad \
        gstreamer1.0-plugins-ugly \
        locales-all \
        tzdata \
        && \
    npm install -g cordova@7.0.0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install go
RUN wget https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz && \
    tar -xvf go1.12.5.linux-amd64.tar.gz && \
    mv go /usr/local && \
    ln -s /usr/include/x86_64-linux-gnu/qt5/QtCore/5.9.5/QtCore /usr/include/ && \
    rm go1.12.5.linux-amd64.tar.gz

# Rust env vars
ENV CARGO_HOME=/opt/rust/cargo \
    RUSTUP_HOME=/opt/rust/rustup \
    PATH=/opt/rust/cargo/bin:$PATH

# Install Rust
RUN mkdir -p opt/rust && \
    wget https://sh.rustup.rs -O rustup.sh && \
    bash rustup.sh -y --default-toolchain '1.36.0' && \
    rm rustup.sh && \
    rustup target add armv7-unknown-linux-gnueabihf && \
    # Allow the default clickable user to update the registry as well as the git folder
    mkdir -p /opt/rust/cargo/registry && \
    chown -R 1000 /opt/rust/cargo/registry && \
    mkdir -p /opt/rust/cargo/git && \
    chown -R 1000 /opt/rust/cargo/git

# Add user phablet
RUN groupadd -r phablet -g 1000 && useradd -u 1000 -r -g phablet -m -d /home/phablet -s /sbin/nologin -c "phablet user"  phablet && \
    chmod 755 /home/phablet

# TODO this probably needs to be fixed upstream
ADD ubuntu-click-tools.prf /usr/lib/x86_64-linux-gnu/qt5/mkspecs/features/ubuntu-click-tools.prf

ADD xvfb-startup.sh /usr/local/bin/xvfb-startup
RUN chmod +x /usr/local/bin/xvfb-startup

# Add clickabe compatibility version file
ADD image_version /image_version

ENV CGO_ENABLED=1
