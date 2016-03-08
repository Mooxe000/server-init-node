plan = require 'flightplan'
server = require '../ssh/config.coffee'

module.exports = ->

  plan.target 'docker'
  ,
    host: server.docker.host
    username: server.docker.user
    agent: process.env.SSH_AUTH_SOCK

  plan.local 'hello', (l) ->
    l.log 'local 2'
    l.log 'Hello World!!!'

  plan.remote 'hello', (r) ->
    r.log 'remote'
    r.log 'Hello World!!!'

  plan.local 'hello', (l) ->
    l.log 'local 1'
    l.log 'Hello World!!!'
