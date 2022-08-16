#!/bin/bash

if [ "$DEBUG" == "true" ]; then
  echo "debug mode is on"
  rdebug-ide --host 0.0.0.0 --port 1234 --dispatcher-port 26162 -- /usr/local/bundle/bin/bundle exec $*
else
  "$@"
fi
