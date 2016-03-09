plan = require 'flightplan'

tasks =

  env: (t) ->
    t.exec """
      echo "export DEBIAN_FRONTEND=noninteractive" >> ~/.bashrc && \
      echo "export EDITOR=vim" >> ~/.bashrc
    """

  local: (t) ->
    t.exec """
      locale-gen en_US.UTF-8 && \
      /usr/sbin/update-locale LANG=en_US.UTF-8
    """

  aptkey: (t) ->
    t.exec """
      apt-key adv --recv-keys \
      --keyserver keyserver.ubuntu.com \
      40976EAF437D05B5 3B4FE6ACC0B21F32
    """

  aptitude: (t) ->
    t.exec 'apt-get install -y aptitude'

  update: (t) ->
    t.exec """
      aptitude update && \
      1 | aptitude -y upgrade && \
      apt-get -y autoremove
    """

  inspkgs: (t) ->
    t.exec """
      aptitude install -y \
        curl axel htop make \
        software-properties-common
    """
    t.exec """
      add-apt-repository ppa:git-core/ppa
    """
    t.exec """
      aptitude install -y git-core
    """

  docker:
    group: (t) ->
      t.exec """
        if grep -q wheel /etc/group; \
        then groupdel wheel; \
        fi && \
        groupadd wheel
      """
    user: (t) ->
      t.exec """
        if grep -q docker /etc/shadow; \
        then userdel -rf docker; \
        fi && \
        useradd -m -G wheel -p netserver -s /bin/bash docker
      """
    authkey: (t) ->
      t.exec """
        mkdir -p /home/docker/.ssh && \
        cp ~/.ssh/authorized_keys /home/docker/.ssh && \
        chown -R docker /home/docker/.ssh
      """
    sudo: (t) ->
      t.exec """
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

  tasks.docker.group t
  tasks.docker.user t
  tasks.docker.authkey t
  tasks.docker.sudo t

module.exports = all
