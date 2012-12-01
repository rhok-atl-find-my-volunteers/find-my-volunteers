express = require 'express'
app = express()
app.enable 'trust proxy'

app.configure(->
  app.use(app.router)
  app.use(express.static(__dirname + '/public'))
)
app.get '/', (req, res)->
  res.sendfile(__dirname + '/public/index.html')

app.listen 3000 or process.env.PORT
console.log 'listening...'
