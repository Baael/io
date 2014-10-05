express = require 'express.io'
app     = express()
app.http().io()

Firebase = require('firebase');
db = new Firebase('https://fiery-fire-1444.firebaseio.com/')


app.io.route 'proxy', (req)->
  req.io.route(req.data.c, req.data)   if req.data?.c?

# join channel
app.io.route 'join', (req)->
    return if (!req.data.r)
    req.io.join(req.data.r)
    app.io.room(req.data.r).broadcast 'rcv', {joined: req.data.v, channel: req.data.r}

# leave channel
app.io.route 'leave', (req)->
  return if !req.data.r
  req.io.leave(req.data.r)

# broadcast message
app.io.route 'send', (req)->
  return if !req.data.r
  app.io.room(req.data.r).broadcast 'rcv', req.data

app.io.route 'set', (req)->
  db.set(req.data)

app.use express.static('./public')
app.listen(5556)
