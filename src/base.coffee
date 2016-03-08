plan = require 'flightplan'

tasks =

  env: (t) ->
    t.exec """
      echo "export DEBIAN_FRONTEND=noninteractive" \
        >> ~/.bashrc
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

  shell:

    tty: (t) ->
      t.exec """
        sed -i '/mesg\ n/d' /root/.profile && \
        echo 'tty -s \&\& mesg n' >> /root/.profile
      """

    bash: (t) ->
      t.exec """
        rm -rf ~/.bash_it && \
        git clone \
          https://github.com/Bash-it/bash-it.git ~/.bash_it && \
        bash -lc \"yes | ~/.bash_it/install.sh\"
      """

    zsh:

      ins: (t) ->
        t.exec """
          aptitude install -y zsh
        """

      omz: (t) ->
        t.exec """
          rm -rf ~/.oh-my-zsh && rm -rf ~/.zshrc && \
          git clone \
            https://github.com/robbyrussell/oh-my-zsh.git \
            ~/.oh-my-zsh && \
          cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
        """

    fish:

      ins: (t) ->
        t.exec """
          add-apt-repository ppa:fish-shell/nightly-master
        """
        t.exec """
          aptitude install -y fish
        """

      fisherman: (t) ->
        t.exec """
          rm -rf ~/.local/share/fisherman && \
          git clone \
            https://github.com/fisherman/fisherman \
            ~/.local/share/fisherman && \
          cd ~/.local/share/fisherman && \
          make && cd ~ && \
          sed -i 's/^source/./g' ~/.config/fish/config.fish
        """

      config: (t) ->
        t.exec """
          sed -i '/fish_greeting/d' ~/.config/fish/config.fish && \
          sed -i '/en_US.UTF-8/d' ~/.config/fish/config.fish
        """

        t.exec """
          sed -i \"1i \
        set fish_greeting '' \\n\
        set -x LC_ALL en_US.UTF-8 \\n\
        set -x LC_CTYPE en_US.UTF-8 \\n\
          \" ~/.config/fish/config.fish
        """

all = (t) ->

  tasks.env t
  tasks.local t
  tasks.aptkey t

  tasks.aptitude t
  tasks.update t
  tasks.inspkgs t

  tasks.shell.tty t
  tasks.shell.bash t

  tasks.shell.zsh.ins t
  tasks.shell.zsh.omz t

  tasks.shell.fish.ins t
  tasks.shell.fish.fisherman t
  tasks.shell.fish.config t

now = (t) ->

module.exports = all
