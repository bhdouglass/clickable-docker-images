FROM clickable/amd64-16.04-arm64:16.04.3

# Upgrade Qt to 5.12
RUN echo "deb http://repo.ubports.com xenial_-_qt-5-12 main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    # Cleanup
    apt-get -y remove \
    	qt5-qmake-arm-linux-gnueabihf \
	qtdeclarative5-folderlistmodel-plugin:arm64 \
	qtdeclarative5-localstorage-plugin:arm64 \
	qtdeclarative5-particles-plugin:arm64 \
	qtdeclarative5-qtquick2-plugin:arm64 \
	qtdeclarative5-window-plugin:arm64 \
	qtdeclarative5-xmllistmodel-plugin:arm64 && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ln -sf /usr/lib/aarch64-linux-gnu/qt5/bin/qmake /usr/local/bin/qmake

ENV DEB_BUILD_MULTIARCH=.
