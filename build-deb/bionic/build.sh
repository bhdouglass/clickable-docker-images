#!/bin/bash

set -Eeou pipefail

docker build -t clickable/build-deb:bionic . --no-cache
