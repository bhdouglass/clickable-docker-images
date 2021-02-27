#!/bin/bash

set -Eeou pipefail

docker build -t clickable/build-deb:focal . --no-cache
