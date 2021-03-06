#!/bin/bash

set -eou pipefail

docker build -t clickable/build-deb:xenial . --no-cache
