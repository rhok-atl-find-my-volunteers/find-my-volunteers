express = require 'express'
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

app.listen process.env.PORT or 3000
console.log 'listening...'
