plan = require 'flightplan'
server = require '../ssh/config.coffee'

tasks =
  base: require './base.coffee'
  shell: require './shell.coffee'

module.exports = ->

  plan.target 'docker'
  ,
    host: server.docker.host
    username: server.docker.user
    agent: process.env.SSH_AUTH_SOCK

  plan.remote 'default', (r) ->
    r.log 'remote'
    r.log 'Hello World!!!'

  plan.remote 'base', (r) ->
    tasks.base r

  plan.remote 'shell', (r) ->
    tasks.shell r
