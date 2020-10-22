#!/bin/bash

docker build -t clickable/ci-16.04-arm64 -f ./Dockerfile .. --no-cache
