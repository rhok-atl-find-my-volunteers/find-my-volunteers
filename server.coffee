express = require 'express'
util = require 'util'

app = express()
app.enable 'trust proxy'

app.configure(->
  app.use(express.logger())
  app.use(app.router)
  app.use(express.static(__dirname + '/public'))
)

app.get '/', (req, res)->
  res.sendfile(__dirname + '/public/index.html')

app.get '/api/hello', (req, res)->
  res.send 'Hello World!'

app.post '/api/register', (req, res)->
  res.send 204

app.listen process.env.PORT or 5000
console.log "listening..."
console.log "Settings #{util.inspect app.settings}"
