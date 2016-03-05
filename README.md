# Init Server Use Node [Flightplan](https://github.com/pstadler/flightplan)

### config file

```coffee
# config_path = ${pj_root}/ssh/config.coffee
module.exports =

  docker:
    host: "#{ip}"
    user: "#{login_user}"
    pswd: "#{password}"
    key: "#{key_s_name}"
```

### run tasks

```
fly ${task}:${target}
```

### flow

```bash
# 1. 切换 fish-shell
npm run fish
# 3. 添加 私钥
npm run import_keys
npm run flightplan
```

### Keng

#### Permission denied

全局安装 flightplan 时，安装 依赖 fibers 时，
如果 报 如下的错误

```
> node build.js || nodejs build.js

sh: 1: node: Permission denied
sh: 1: nodejs: Permission denied
```

**- 解决办法：**

执行

```
(c)npm config set unsafe-perm true
```

#### ssh-agent of fish-shell

在 fish-shell 中 开启 ssh-agent 服务后，使用 ssh-add 添加 私钥的时候会报

```
Could not open a connection to your authentication agent.
```

**- 解决办法：**

```
ssh-agent fish
```
