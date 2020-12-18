FROM clickable/amd64-16.04-armhf:16.04.3

# Upgrade Qt to 5.12
RUN echo "deb http://repo.ubports.com xenial_-_qt-5-12 main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    # Cleanup
    apt-get -y remove \
    	qt5-qmake-arm-linux-gnueabihf \
	qtdeclarative5-folderlistmodel-plugin:armhf \
	qtdeclarative5-localstorage-plugin:armhf \
	qtdeclarative5-particles-plugin:armhf \
	qtdeclarative5-qtquick2-plugin:armhf \
	qtdeclarative5-window-plugin:armhf \
	qtdeclarative5-xmllistmodel-plugin:armhf && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ln -sf /usr/lib/arm-linux-gnueabihf/qt5/bin/qmake /usr/local/bin/qmake

ENV DEB_BUILD_MULTIARCH=.
