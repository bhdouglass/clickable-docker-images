ARG HOST_ARCH
FROM clickable/$HOST_ARCH-16.04-$HOST_ARCH

LABEL maintainer="Clickable Team"
LABEL Modified by Lionel Duboeuf
LABEL Modified by Daniel Frost

##install qt-creator
COPY libqbscore1.10.equivs-control /tmp/libqbscore1.10.equivs-control
RUN apt-get update && apt-get install -y equivs
RUN cd /tmp && equivs-build /tmp/libqbscore1.10.equivs-control && \
    dpkg -i ./libqbscore1.10_1.0_all.deb

RUN apt-get install -y qtcreator && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

##install plugins for qt-creator
COPY plugins.csv /tmp/plugins.csv
COPY register_plugins.sh /tmp/register_plugins.sh
RUN cd /tmp && chmod +x register_plugins.sh && ./register_plugins.sh
#Workaround for missing top menu bar
ENV QT_QPA_PLATFORMTHEME=

##install atom editor
RUN wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list' && \
    apt-get update && \
    apt-get install -y atom && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#install atom-clickable-plugin
#install some more plugins that should ease development
RUN apm install atom-clickable-plugin \
    atom-ide-base \
    atom-ide-debugger \
    atom-ide-console \
    atom-ide-debugger-native-gdb \
    atom-ide-debugger-python \
    ide-clangd \
    ide-rust \
    ide-go \
    ide-json \
    ide-html \
    ide-css \
    ide-yaml \
    ide-vue

#install clickable in container for atom plugin to use
ENV CLICKABLE_CONTAINER_MODE=1
RUN add-apt-repository ppa:bhdouglass/clickable && \
    apt-get update && \
    apt-get install -y clickable && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#install some common languages to be used by atom spell-check plugin
RUN apt-get update && \
    apt-get install -y hunspell-ca \
    hunspell-cs \
    hunspell-de-de \
    hunspell-en-gb \
    hunspell-en-us \
    hunspell-es \
    hunspell-fr \
    hunspell-it \
    hunspell-pl \
    hunspell-ru \
    hunspell-sv && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
