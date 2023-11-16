#!/bin/bash

# store secret env in this file, this file ignored in git
if [ -r "$oneBash/secret.env" ]; then
  source $oneBash/secret.env
fi