express = require 'express'
app = express()
app.enable 'trust proxy'

app.get '/', (req, res)->
  res.send 'Hello World!'

app.listen 3000 or process.env.port
console.log 'listening...'
