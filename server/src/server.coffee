express = require 'express.io'
app     = express()
app.http().io()

# join channel
app.io.route 'join', (req)->
    return if (!req.data.room)
    id = req.data.room
    req.io.join(id)
    app.io.room(id).broadcast 'rcv', { joined: req.data.sender }

# leave channel
app.io.route 'leave', (req)->
    return if (!req.data.room)
    id = req.data.room
    req.io.leave(id)
    app.io.room(id).broadcast 'rcv', {left: req.data.sender}

# broadcast message
app.io.route 'send', (req)->
  data = req.data
  id = data.room
  delete data.room
  app.io.room(id).broadcast 'rcv', data


app.use express.static('./public')
app.listen(5555)
