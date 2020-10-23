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
        g++ \
        libc-dev \
        libicu-dev \
        isc-dhcp-client \
        nodejs \
        qbs \
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
        qml-module-qtcontacts \
        qtdeclarative5-ubuntu-contacts0.1 \
        qtdeclarative5-qtcontacts-plugin \
        qtdeclarative5-ubuntu-addressbook0.1 \
        qtdeclarative5-gsettings1.0 \
        qtdeclarative5-ubuntu-telephony-phonenumber0.1 \
        qtdeclarative5-ubuntu-history0.1 \
        qtdeclarative5-ubuntu-telephony0.1 \
        qtdeclarative5-ubuntu-keyboard-extensions0.1 \
        qml-module-qt-labs-folderlistmodel \
        qml-module-qt-labs-platform \
        qml-module-qt-labs-settings \
        qml-module-ofono \
        qml-module-morph-web \
        qml-module-qtquick-dialogs \
        qml-module-qtquick-extras \
        libofono-qt-dev \
        libqofono-dev \
        telepathy-mission-control-5 \
        libmission-control-plugins0 \
        libphonenumber-dev \
        libsqlite3-dev \
        libtelepathy-qt5-dev \
        libglib2.0-dev \
        libqt5gstreamer-dev \
        dconf-service \
        libmission-control-plugins-dev \
        libandroid-properties-dev \
        libandroid-properties1 \
        qtwebengine5-dev \
        libconnectivity-qt1-dev \
        libnotify-dev \
        libtag1-dev \
        libsmbclient-dev \
        libpam0g-dev \
        python3-requests \
        python3-gnupg \
        xvfb \
        valgrind \
        gdb \
        gdbserver \
        gstreamer1.0-plugins-good \
        gstreamer1.0-plugins-bad \
        gstreamer1.0-plugins-ugly \
        locales-all \
        tzdata \
        upstart \
        qtubuntu-appmenutheme \
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
    ln -s /usr/include/x86_64-linux-gnu/qt5/QtCore/5.9.5/QtCore /usr/include/ && \
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
    # Allow the default clickable user to update the registry as well as the git folder
    mkdir -p /opt/rust/cargo/registry && \
    chown -R 1000 /opt/rust/cargo/registry && \
    mkdir -p /opt/rust/cargo/git && \
    chown -R 1000 /opt/rust/cargo/git

# QBS setup
RUN qbs setup-toolchains --system --detect && \
    qbs setup-qt --system /usr/bin/qmake qt5 && \
    qbs config --system defaultProfile qt5 && \
    qbs config --system profiles.qt5.baseProfile gcc

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
ENV QT_QPA_PLATFORMTHEME=ubuntuappmenu
