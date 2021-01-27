FROM clickable/amd64-16.04-armhf
LABEL image_version="4"

# Pin Qt 5.9 and packages depending on it
COPY pin_qt_5.9.sh .
RUN sh pin_qt_5.9.sh > /etc/apt/preferences.d/qt && rm pin_qt_5.9.sh

# Reinstall all Qt/SDK packages
RUN QT_PACKAGES="\
        qtbase5-private-dev:armhf \
        qtdeclarative5-private-dev:armhf \
        qtfeedback5-dev:armhf \
        qtpositioning5-dev:armhf \
        qtquickcontrols2-5-dev:armhf \
        qtsystems5-dev:armhf \
        qtwebengine5-dev:armhf \
        libqt5opengl5-dev:armhf \
        ubuntu-sdk-libs-dev:armhf \
        ubuntu-sdk-libs-tools \
        ubuntu-sdk-libs:armhf \
        libconnectivity-qt1-dev:armhf \
    " && \
    apt-get update && \
    apt-get -y remove libqt5core5a:armhf $QT_PACKAGES && \
    apt-get -y --no-install-recommends install $QT_PACKAGES && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
