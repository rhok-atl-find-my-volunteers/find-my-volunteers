express = require 'express'
app = express()

app.get '/', (req, res)->
  body = 'Hey!'
  res.setHeader 'Content-Type', 'text/plain'
  res.setHeader 'Content-Length', body.length
  res.end body
# this is a useless comment
