#!/bin/bash

docker build -t clickable/ci-16.04-amd64 -f ./Dockerfile .. --no-cache
