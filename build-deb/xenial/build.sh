#!/bin/bash

set -Eeou pipefail

docker build -t clickable/build-deb:xenial . --no-cache
