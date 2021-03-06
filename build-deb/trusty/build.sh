#!/bin/bash

set -eou pipefail

docker build -t clickable/build-deb:trusty . --no-cache
