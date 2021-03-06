#! /bin/sh

pin () {
    # The first parameter is the version number to pin to, all other parameters
    # are package names or patterns
    VERSION="$1"
    shift
    for PACKAGE in "$@"
    do
        echo "Package: $PACKAGE\nPin: version $VERSION\nPin-Priority: 1001\n"
    done
}

pin '5.9.*' \
    libqt53d\* \
    libqt5bluetooth5\* \
    libqt5charts5\* \
    libqt5concurrent5\* \
    libqt5core5a\* \
    libqt5dbus5\* \
    libqt5designer\* \
    libqt5gui5\* \
    libqt5help5 \
    libqt5location5\* \
    libqt5multimedia\* \
    libqt5network5\* \
    libqt5nfc5\* \
    libqt5opengl5\* \
    libqt5positioning5\* \
    libqt5printsupport5\* \
    libqt5qml5\* \
    libqt5quick5\* \
    libqt5quickcontrols2-5\* \
    libqt5quickparticles5\* \
    libqt5quicktemplates2-5\* \
    libqt5quicktest5\* \
    libqt5quickwidgets5\* \
    libqt5script\* \
    libqt5sensors5\* \
    libqt5sql5\* \
    libqt5svg5\* \
    libqt5test5\* \
    libqt5webchannel5\* \
    libqt5websockets5\* \
    libqt5widgets5\* \
    libqt5xml5\* \
    libqt5xmlpatterns5\* \
    qdbus-qt5 \
    qdoc-qt5 \
    qhelpgenerator-qt5 \
    qml \
    qml-module-qt-labs-\* \
    qml-module-qt3d \
    qml-module-qt\*websockets \
    qml-module-qtaudioengine \
    qml-module-qtbluetooth \
    qml-module-qtcharts \
    qml-module-qtgraphicaleffects \
    qml-module-qtlocation \
    qml-module-qtmultimedia \
    qml-module-qtnfc \
    qml-module-qtpositioning \
    qml-module-qtqml-\* \
    qml-module-qtquick-\* \
    qml-module-qtquick2 \
    qml-module-qtsensors \
    qml-module-qttest \
    qml-module-qtwebchannel \
    qmlscene \
    qt3d\* \
    qt5-assistant \
    qt5-default \
    qt5-gtk-platformtheme \
    qt5-image-formats-plugins \
    qt5-qmake\* \
    qt5-qmltooling-plugins \
    qtbase5\* \
    qtcharts5\* \
    qtconnectivity5\* \
    qtdeclarative5-dev \
    qtdeclarative5-dev-tools \
    qtdeclarative5-private-dev \
    qtgraphicaleffects5\* \
    qtlocation5\* \
    qtmultimedia5\* \
    qtpositioning5\* \
    qtquickcontrols2-5\* \
    qtscript5\* \
    qtsensors5\* \
    qtsvg5\* \
    qttools5\* \
    qtwebchannel5\* \
    qtwebsockets5\* \
    qtxmlpatterns5\*

pin '5.0~git20130529-0ubports1' \
    libqt5feedback5\* \
    qml-module-qtfeedback \
    qtfeedback5\*

pin '5.0~git20171109*' \
    libqt5contacts5\* \
    libqt5organizer5\* \
    libqt5versit\* \
    qml-module-qtcontacts \
    qml-module-qtorganizer \
    qtdeclarative5-qtcontacts\* \
    qtdeclarative5-qtorganizer\* \
    qtpim5\* \

pin '5.1+ubports+0~20180517225040*' \
    libqt5publishsubscribe5\* \
    libqt5serviceframework5\* \
    libqt5systeminfo5\* \
    qml-module-qtpublishsubscribe \
    qml-module-qtserviceframework \
    qml-module-qtsysteminfo \
    qtdeclarative5-publishsubscribe\* \
    qtdeclarative5-serviceframework\* \
    qtdeclarative5-systeminfo\* \
    qtsystems5\*

pin '5.14.2+dfsg-3ubports0' \
    libqt5webengine\* \
    qml-module-qtwebengine \
    qtwebengine5\* \

pin '5.212.0~alpha2-7ubports3' \
    libqt5webkit5\* \
    qml-module-qtwebkit \

pin '1.3.2192~0ubports1+0~20201106203828.18*' \
    libubuntugestures5\* \
    libubuntumetrics5\* \
    libubuntutoolkit5\* \
    qml-module-ubuntu-components\* \
    qml-module-ubuntu-layouts \
    qml-module-ubuntu-metrics \
    qml-module-ubuntu-performancemetrics \
    qml-module-ubuntu-test \
    qtdeclarative5-ubuntu-ui-toolkit-plugin \
    ubuntu-app-launch-profiler \
    ubuntu-ui-toolkit\* \

pin '0.2+ubports+0~20181109035536*' \
    libonline-accounts-qt\* \
    qml-module-ubuntu-onlineaccounts2 \

pin '0.9~0ubports1+0~20191217001219*' \
    libonline-accounts-client\* \
    libonline-accounts-plugin\* \
    qml-module-ubuntu-onlineaccounts-client \

pin '0.65.1+ubports+0~20191223175818.11*' \
    qtubuntu-android \
    qtubuntu-appmenutheme \
    qtubuntu-desktop \

pin '0.4~0ubports1+0~20201112195138.49*' \
    qtdeclarative5-ubuntu-addressbook0.1 \
    qtdeclarative5-ubuntu-contacts0.1 \

pin '1.19.8-ubports2' \
    liboxideqt\* \
    oxideqt-\* \

pin '0.24+ubports+0~20201218222414.37*' \
    morph-browser \
    morph-webapp-container \
    qml-module-morph-web\* \
    qml-module-ubuntu-web\* \
    qtdeclarative5-ubuntu-web-plugin\* \

pin '0.2+ubports+0~20200715204844*' \
    '*gsettings-qt*' \
    qtdeclarative5-gsettings1.0 \

pin '0.4+0ubports3+0~20201130183009.16*' \
    account-plugin-irc-unity8 \
    account-plugin-sip-unity8 \
    qtdeclarative5-ubuntu-telephony\* \
    telephony-service \

pin '0.8.1+ubports1+0~20201222151254*' \
    '*connectivity-qt1*' \
    qml-module-ubuntu-connectivity \

pin '0.3+ubports+0~20201007205921.11*' \
    '*content-hub*' \
    qtdeclarative5-ubuntu-content1 \

pin '1.4+ubports+0~20201109171628.4*' \
    libubuntu-download-manager-\* \
    libubuntu-upload-manager-\* \
    libudm-common\* \
    libudm-priv-common1 \
    qtdeclarative5-ubuntu-download-manager0.1 \
    ubuntu-download-manager \
    ubuntu-upload-manager \

pin '0.7+ubports+0~20180109155305.3*' \
    accounts-qml-module-doc \
    qml-module-ubuntu-onlineaccounts \
    qtdeclarative5-accounts-plugin \

pin '0.2+ubports+0~20180625192919.3*' \
    qtdeclarative5-ubuntu-push-plugin \
    ubuntu-push-qml \

pin '0.3~0ubports4+0~20201008192646.14*' \
    history-service\* \
    libhistoryservice\* \
    qtdeclarative5-ubuntu-history0.1 \

pin '0.20180223ubuntu1+0~20200928182259.3*' qml-module-qtquick-controls2-suru
pin '5.52*' '*kirigami2*'
pin '1.5.3*' '*pyotherside*'
pin '1.433xenial1ubports25*' ubuntu-sdk\*
pin '0.100+15.04+ubports+0~20201222150932.39*' '*ubuntu-keyboard*'
pin '1.1.2+ubports+0~20200517193233.3*' '*usermetrics*'
pin '1.7.2+ubports+0~20201216165219.28*' '*libertine*'
