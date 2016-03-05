#!/usr/bin/env bash

cwd="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

set -e

cd $cwd

global() {
  cnpm config set unsafe-perm true
  cnpm install -g flightplan
}

reinstall() {
  cnpm install --save-dev \
    coffee-script \
    lodash \
    shelljs \
    ddeyes \
    flightplan
}

helper() {
  echo ''
  echo 'commands:'
  echo ''
  echo '  flightplan      - install flightplan with global'
  echo '  install   - reinstall all of require packages.'
}

command=$1

case $command in
  'flightplan')
  global
  ;;
  'install')
  reinstall
  ;;
  'help')
  helper
  ;;
  *)
  helper
  ;;
esac

####

# for i in $@; do
#   echo $i
# done

# select command in 'global' 'reinstall' 'helper'; do
# done
