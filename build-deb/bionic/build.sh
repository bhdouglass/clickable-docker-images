#!/bin/bash

set -eou pipefail

docker build -t clickable/build-deb:bionic . --no-cache
