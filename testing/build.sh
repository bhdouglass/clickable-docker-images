#!/bin/bash

set -eou pipefail

docker build -t clickable/testing . --no-cache
