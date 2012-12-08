express = require 'express'
util = require 'util'
sms = require './sms'
registration = require './registration'

db = require './db'
(require './couch_views/create_views')(db.connect)

people_search = require './search/people'
checkins_search = require './search/checkins'
aliases_search = require './search/aliases'

aliases = require './entity_manipulations/aliases'
people = require './entity_manipulations/people'

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
  sms.receive db.connect(), req, res

app.post '/api/sms/send', (req, res)->
  res.send 204 if sms.send {body: req.body.message, contacts: req.body.contacts}

app.post '/api/register', (req, res)->
  registration.register db.connect(), req, res

app.get '/api/people/search', (req, res)->
  people_search.go db.connect(), req, res

app.post '/api/person/:id/site', (req, res)->
  people.set_post db.connect(), req, res

app.get '/api/checkins/search', (req, res)->
  checkins_search.go db.connect(), req, res

app.get '/api/aliases', (req, res)->
  aliases_search.go db.connect(), req, res

app.post '/api/alias', (req, res)->
  aliases.add db.connect(), req, res

if not process.env.TWILIO_SID
  throw Exception "Need Twilio Api Sid"
if not process.env.TWILIO_AUTH_TOKEN
  throw Exception 'Need Twilio Api Auth Token'

app.listen process.env.PORT or 5000

console.log "listening..."
