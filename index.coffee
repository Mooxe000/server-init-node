#!/usr/bin/env coffee

require 'shelljs/make'

echo = console.log

target.all = ->

  exec 'fly base:docker'
  exec 'fly shell:docker'
  exec 'fly shell:docker --username=docker'
  exec 'fly docker:docker --username=docker'

  # echo 'Hello Wolrd!!!'
