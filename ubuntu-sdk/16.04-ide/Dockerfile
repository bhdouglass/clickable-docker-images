ARG HOST_ARCH
FROM clickable/$HOST_ARCH-16.04-$HOST_ARCH

LABEL maintainer="Clickable Team"
LABEL Modified by Lionel Duboeuf
LABEL Modified by Daniel Frost

## install QtCreator
COPY libqbscore1.10.equivs-control /tmp/libqbscore1.10.equivs-control
RUN apt-get update && apt-get install -y equivs
RUN cd /tmp && equivs-build /tmp/libqbscore1.10.equivs-control && \
    dpkg -i ./libqbscore1.10_1.0_all.deb

RUN apt-get install -y \
	qtcreator && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

## install QtCreator plugins
COPY plugins.csv /tmp/plugins.csv
COPY register_plugins.sh /tmp/register_plugins.sh
RUN cd /tmp && chmod +x register_plugins.sh && ./register_plugins.sh
#Workaround for missing top menu bar
ENV QT_QPA_PLATFORMTHEME=

## install atom editor
RUN wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
RUN apt-get update
RUN apt-get install -y atom
##install atom-clickable-plugin
RUN apm install atom-clickable-plugin
