executivor = (t, args...) ->
  if process.env.sudo
  then t.exec "sudo bash -lc \"#{args}\""
  else t.exec args

exports.executivor = executivor
