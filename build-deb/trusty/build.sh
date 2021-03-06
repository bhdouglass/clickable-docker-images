#!/bin/bash

set -Eeou pipefail

docker build -t clickable/build-deb:trusty . --no-cache
