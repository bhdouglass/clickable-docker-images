#!/bin/bash

docker build -t clickable/amd64-16.04-arm64 -t clickable/ubuntu-sdk:16.04-arm64 . --no-cache
