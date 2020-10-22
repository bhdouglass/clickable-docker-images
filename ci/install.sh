#/bin/bash

set -x
set -e

apt-get update
apt-get -y -f --no-install-recommends install gnupg ubuntu-keyring software-properties-common
add-apt-repository ppa:bhdouglass/clickable
apt-get update
apt-get install -y clickable locales-all
apt-get -y remove wget
apt-get -y autoremove
apt-get clean
rm -rf /var/lib/apt/lists/*
