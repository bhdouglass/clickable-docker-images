#!/bin/bash

set -eou pipefail

docker build -t clickable/build-deb:focal . --no-cache
