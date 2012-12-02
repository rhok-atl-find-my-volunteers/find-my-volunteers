express = require 'express'
util = require 'util'
cradle = require 'cradle'
sms = require './sms'
registration = require './registration'

connect = ()->
  prod = !!process.env.CLOUDANT_URL
  url = 'http://127.0.0.1'
  url = process.env.CLOUDANT_URL if prod
  port = 5984
  port = 443 if prod

  (new cradle.Connection url, port, {
    cache: true
    raw: false
  }).database 'db'

app = express()
app.enable 'trust proxy'

app.configure(->
  app.use(express.logger())
  app.use(express.bodyParser())
  app.use(app.router)
  app.use(express.static(__dirname + '/public'))
)

app.get '/', (req, res)->
  res.sendfile(__dirname + '/public/index.html')

app.post '/api/sms/receive', (req, res)->
  sms.receive connect(), req, res

app.post '/api/register', (req, res)->
  registration.register connect(), req, res

app.listen process.env.PORT or 5000

console.log "listening..."
console.log "Settings #{util.inspect app.settings}"