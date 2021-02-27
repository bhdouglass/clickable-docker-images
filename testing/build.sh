#!/bin/bash

set -Eeou pipefail

docker build -t clickable/testing . --no-cache
