#!/bin/bash

export nodeBin="$HOME/.node/v${NODE_VERSION:-20}/bin"
if [ -d $nodeBin ]
then
  export PATH="$PATH:$nodeBin"
  # export NODE_OPTIONS="--max-old-space-size=4096"
else
  echoError "Setup node error! '$nodeBin' not exist!"
fi
