#!/usr/bin/env coffee

require 'shelljs/make'

echo = console.log

target.all = ->

  # fly base:docker
  # fly shell:docker
  # fly shell:docker --username=docker

  echo 'Hello Wolrd!!!'
