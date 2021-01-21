FROM clickable/arm64-16.04-arm64
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
        libconnectivity-qt1-dev \
    " && \
    apt-get update && \
    apt-get -y remove $QT_PACKAGES && \
    apt-get -y autoremove && \
    apt-get -y --no-install-recommends install $QT_PACKAGES && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
