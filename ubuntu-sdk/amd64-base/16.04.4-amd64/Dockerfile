FROM clickable/amd64-16.04-amd64:16.04.5
LABEL image_version="4"

# Pin Qt 5.9 and packages depending on it
COPY pin_qt_5.9.sh .
RUN sh pin_qt_5.9.sh > /etc/apt/preferences.d/qt && rm pin_qt_5.9.sh

# Reinstall all Qt/SDK packages
RUN QT_PACKAGES="\
        qtbase5-private-dev \
        qtdeclarative5-private-dev \
        qtfeedback5-dev \
        qtpositioning5-dev \
        qtquickcontrols2-5-dev \
        qtsystems5-dev \
        qtwebengine5-dev \
        libqt5opengl5-dev \
        ubuntu-sdk-libs-dev \
        ubuntu-sdk-libs-tools \
        ubuntu-sdk-libs \
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
        libofono-qt-dev \
        libqofono-dev \
        libtelepathy-qt5-dev \
        libqt5gstreamer-dev \
        qtwebengine5-dev \
        libconnectivity-qt1-dev \
    " && \
    apt-get update && \
    apt-get -y remove libqt5core5a $QT_PACKAGES && \
    apt-get -y autoremove && \
    apt-get -y --no-install-recommends install $QT_PACKAGES && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
