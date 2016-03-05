#!/usr/bin/env bash

cwd="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

set -e

echo ''

echo ' - add keys:'
for key in `ls ${cwd}/keys`; do
  ssh-add ${cwd}/keys/$key
done

echo ''

echo ' - list keys:'
ssh-add -L
