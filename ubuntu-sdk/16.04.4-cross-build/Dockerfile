ARG HOST_ARCH
ARG TARGET_ARCH

FROM clickable/$HOST_ARCH-16.04-$TARGET_ARCH

ARG TARGET_ARCH

# Pin Qt 5.9 and packages depending on it
COPY pin_qt_5.9.sh .
RUN sh pin_qt_5.9.sh > /etc/apt/preferences.d/qt && rm pin_qt_5.9.sh

# Reinstall all Qt/SDK packages
RUN QT_PACKAGES="\
        qtbase5-private-dev:$TARGET_ARCH \
        qtdeclarative5-private-dev:$TARGET_ARCH \
        qtfeedback5-dev:$TARGET_ARCH \
        qtpositioning5-dev:$TARGET_ARCH \
        qtquickcontrols2-5-dev:$TARGET_ARCH \
        qtsystems5-dev:$TARGET_ARCH \
        qtwebengine5-dev:$TARGET_ARCH \
        libqt5opengl5-dev:$TARGET_ARCH \
        ubuntu-sdk-libs-dev:$TARGET_ARCH \
        ubuntu-sdk-libs-tools \
        ubuntu-sdk-libs:$TARGET_ARCH \
        libconnectivity-qt1-dev:$TARGET_ARCH \
    " && \
    apt-get update && \
    apt-get -y --allow-downgrades remove libqt5core5a:$TARGET_ARCH $QT_PACKAGES && \
    apt-get -y --allow-downgrades --no-install-recommends install $QT_PACKAGES && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
