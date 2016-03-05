#!/usr/bin/env bash

cwd="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

set -e

pjName="server-reset-node"

docker run \
  --name ${pjName} \
  --rm \
  -ti \
  -v ${cwd}:/root/${pjName} \
  mooxe/node \
  /bin/bash
