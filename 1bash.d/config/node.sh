#!/bin/bash

export NODE_BIN="$HOME/.node/v${NODE_VERSION:-20}/bin"
if [ -d $NODE_BIN ]
then
  export PATH="$PATH:$NODE_BIN"
  # export NODE_OPTIONS="--max-old-space-size=4096"
else
  echoError "Setup node error! '$NODE_BIN' not exist!"
fi
