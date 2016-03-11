echo = console.log
{ executivor } = require './common.coffee'

tasks =

  env: (t) ->
    t.exec """
      sed -i '/DEBIAN_FRONTEND/d' ~/.bashrc && \
      echo "export DEBIAN_FRONTEND=noninteractive" >> ~/.bashrc && \
      sed -i '/EDITOR/d' ~/.bashrc && \
      echo "export EDITOR=vim" >> ~/.bashrc
    """

  local: (t) ->
    executivor t, """
      locale-gen en_US.UTF-8 && \
      /usr/sbin/update-locale LANG=en_US.UTF-8
    """

  aptkey: (t) ->
    executivor t, """
      apt-key adv --recv-keys \
      --keyserver keyserver.ubuntu.com \
      40976EAF437D05B5 3B4FE6ACC0B21F32
    """

  aptitude: (t) ->
    executivor t, 'apt-get install -y aptitude'

  update: (t) ->
    executivor t, """
      aptitude update && \
      1 | aptitude -y upgrade && \
      apt-get -y autoremove
    """

  inspkgs: (t) ->
    executivor t, """
      aptitude install -y \
        software-properties-common \
        make curl axel htop nload
    """
    executivor t, """
      add-apt-repository ppa:git-core/ppa
    """
    executivor t, """
      aptitude install -y git-core
    """

  docker:
    group: (t) ->
      executivor t, """
        if grep -q wheel /etc/group; \
        then groupdel wheel; \
        fi && \
        groupadd wheel
      """
    user: (t) ->
      executivor t, """
        if grep -q docker /etc/shadow; \
        then userdel -rf docker; \
        fi && \
        useradd -m -G wheel -p netserver -s /bin/bash docker
      """
    authkey: (t) ->
      executivor t, """
        mkdir -p /home/docker/.ssh && \
        cp ~/.ssh/authorized_keys /home/docker/.ssh && \
        chown -R docker /home/docker/.ssh
      """
    sudo: (t) ->
      executivor t, """
      sed -i '/wheel/d' /etc/sudoers && \
      echo '%wheel  ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers
      """

all = (t) ->

  tasks.env t
  tasks.local t
  tasks.aptkey t

  tasks.aptitude t
  tasks.update t
  tasks.inspkgs t

  tasks.docker.group t
  tasks.docker.user t
  tasks.docker.authkey t
  tasks.docker.sudo t

now = (t) ->

  tasks.docker.sudo t

module.exports = all
