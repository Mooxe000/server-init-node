echo = console.log

tasks =

  ins: (t) ->

    url =
      if process.env.dao
      then 'https://get.daocloud.io/docker'
      else 'https://get.docker.com/'

    t.exec """
      curl -sSL #{url} | sh && \
      sudo usermod -aG docker docker
    """

  insCompose: (t) ->

    version = '1.6.2'
    url = [
      'https://github.com/docker/compose/releases/download/'
      version
      '/docker-compose-`uname -s`-`uname -m`'
    ].join ''

    t.exec """
      sudo bash -lc \"curl -L #{url} > \
        /usr/local/bin/docker-compose\" && \
      sudo chmod +x /usr/local/bin/docker-compose
    """

all = (t) ->

  tasks.ins t
  tasks.insCompose t

now = (t) ->

  tasks.ins t

module.exports = all
