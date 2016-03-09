tasks =

  ins: (t) ->

    url =
      g: 'https://get.docker.com/'
      cn: 'https://get.daocloud.io/docker'

    t.exec """
      curl -sSL #{url.cn} | sh
    """

all = (t) ->

  tasks.ins t

module.exports = all
