FROM clickable/amd64-16.04-arm64
LABEL image_version="4"

# Pin Qt 5.9 and packages depending on it
COPY pin_qt_5.9.sh .
RUN sh pin_qt_5.9.sh > /etc/apt/preferences.d/qt && rm pin_qt_5.9.sh

# Reinstall all Qt/SDK packages
RUN QT_PACKAGES="\
        qtbase5-private-dev:arm64 \
        qtdeclarative5-private-dev:arm64 \
        qtfeedback5-dev:arm64 \
        qtpositioning5-dev:arm64 \
        qtquickcontrols2-5-dev:arm64 \
        qtsystems5-dev:arm64 \
        qtwebengine5-dev:arm64 \
        libqt5opengl5-dev:arm64 \
        ubuntu-sdk-libs-dev:arm64 \
        ubuntu-sdk-libs-tools \
        ubuntu-sdk-libs:arm64 \
        libconnectivity-qt1-dev:arm64 \
    " && \
    apt-get update && \
    apt-get -y remove libqt5core5a:arm64 $QT_PACKAGES && \
    apt-get -y --no-install-recommends install $QT_PACKAGES && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
