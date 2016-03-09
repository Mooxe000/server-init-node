plan = require 'flightplan'
server = require '../ssh/config'

tasks =
  base: require './base'
  shell: require './shell'
  docker: require './docker'

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

  plan.remote 'docker', (r) ->
    tasks.docker r
