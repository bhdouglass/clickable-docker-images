#!/bin/bash

# Taken from https://github.com/bengreenier/docker-xvfb/blob/master/docker/xvfb-startup.sh

Xvfb :99 -ac -screen 0 "${XVFB_RES:-540x960x24}" -nolisten tcp $XVFB_ARGS &
XVFB_PROC=$!
sleep 1
export DISPLAY=:99
"$@"
kill $XVFB_PROC
