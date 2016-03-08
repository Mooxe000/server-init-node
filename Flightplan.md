# Flightplan

### plan

```coffee
plan = require 'flightplan'
```

### target

定义 远程 服务器

```coffee
plan.target 'docker'
,
  host: ''
  username: ''
  agent: process.env.SSH_AUTH_SOCK
```

### local && remote

* local 执行本地命令
* remote 执行本地命令
* 多个任务，穿插 local，remote 任务，均是 顺序执行

### Transport

内建工具集合对象

* log
* debug

* hostname
* echo

* exec
* sudo

* rm
* ls
* - cp
* - mv
* - chown
* - chmod

* transfer

* prompt
* waitFor
* with
* silent
* verbose
* failsafe
* unsafe
