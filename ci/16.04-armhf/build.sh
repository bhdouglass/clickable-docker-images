#!/bin/bash

docker build -t clickable/ci-16.04-armhf -f ./Dockerfile .. --no-cache
