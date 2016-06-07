tasks =

  tty: (t) ->
    t.exec """
      sed -i '/mesg\ n/d' ~/.profile && \
      echo 'tty -s \&\& mesg n' >> ~/.profile
    """

  bash: (t) ->
    t.exec """
      rm -rf ~/.bash_it && \
      git clone \
        https://github.com/Bash-it/bash-it.git ~/.bash_it && \
      bash -lc \"yes | ~/.bash_it/install.sh\"
    """

  zsh:
    ins: (t) -> t.exec "sudo aptitude install -y zsh"
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
        sudo add-apt-repository ppa:fish-shell/nightly-master && \
        sudo aptitude install -y fish && \
        sudo aptitude update && \
        1 | sudo aptitude -y upgrade && \
        sudo apt-get -y autoremove
      """

    fisherman: (t) ->
      # git clone \
      #   https://github.com/fisherman/fisherman \
      #   ~/.local/share/fisherman && \
      # cd ~/.local/share/fisherman && \
      # make && cd ~ && \
      # sed -i 's/^source/./g' ~/.config/fish/config.fish
      t.exec """
        rm -rf ~/.local/share/fisherman && \
        curl -Lo ~/.config/fish/functions/fisher.fish \
          --create-dirs git.io/fisherman
      """

    config: (t) ->
      # t.exec """
      #   sed -i '/fish_greeting/d' ~/.config/fish/config.fish && \
      #   sed -i '/en_US.UTF-8/d' ~/.config/fish/config.fish && \
      #   sed -i \"1i \
      # set fish_greeting '' \\n\
      # set -x LC_ALL en_US.UTF-8 \\n\
      # set -x LC_CTYPE en_US.UTF-8 \\n\
      #   \" ~/.config/fish/config.fish
      # """
      t.exec """
        echo "set fish_greeting ''" \
          > ~/.config/fish/config.fish && \
        echo "set -x LC_ALL en_US.UTF-8" \
          >> ~/.config/fish/config.fish && \
        echo "set -x LC_CTYPE en_US.UTF-8" \
          >> ~/.config/fish/config.fish
      """
      t.exec """
        fish -lc 'fisher omf/theme-robbyrussell'
      """

all = (t) ->

  tasks.tty t
  tasks.bash t

  tasks.zsh.ins t
  tasks.zsh.omz t

  tasks.fish.ins t
  tasks.fish.fisherman t
  tasks.fish.config t

module.exports = all
