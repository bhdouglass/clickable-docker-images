FROM clickable/amd64-16.04-amd64:16.04.3

# Upgrade Qt to 5.12
RUN echo "deb http://repo.ubports.com xenial_-_qt-5-12 main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    # Cleanup
    apt-get -y remove \
    	qt5-qmake-arm-linux-gnueabihf \
	qtdeclarative5-folderlistmodel-plugin \
	qtdeclarative5-localstorage-plugin \
	qtdeclarative5-particles-plugin \
	qtdeclarative5-qtquick2-plugin \
	qtdeclarative5-window-plugin \
	qtdeclarative5-xmllistmodel-plugin && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV DEB_BUILD_MULTIARCH=.
