FROM clickable/armhf-16.04-armhf:16.04.3

# Upgrade Qt to 5.12
RUN echo "deb http://repo.ubports.com xenial_-_qt-5-12 main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    # Cleanup
    apt-get -y remove qt5-qmake-arm-linux-gnueabihf && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV DEB_BUILD_MULTIARCH=.
