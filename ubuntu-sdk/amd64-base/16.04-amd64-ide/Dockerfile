FROM clickable/ubuntu-sdk:16.04-amd64
LABEL maintainer="Clickable Team"
LABEL Modified by Lionel Duboeuf

COPY libqbscore1.10.equivs-control /tmp/libqbscore1.10.equivs-control
RUN apt-get update && apt-get install -y equivs
RUN cd /tmp && equivs-build /tmp/libqbscore1.10.equivs-control && \
    dpkg -i ./libqbscore1.10_1.0_all.deb

RUN apt-get install -y \
	qtcreator && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

##install plugins
COPY plugins.csv /tmp/plugins.csv
COPY register_plugins.sh /tmp/register_plugins.sh
RUN cd /tmp && chmod +x register_plugins.sh && ./register_plugins.sh
#Workaround for missing top menu bar
ENV QT_QPA_PLATFORMTHEME=
