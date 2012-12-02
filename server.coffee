express = require 'express'
util = require 'util'
sms = require './sms'
registration = require './registration'
db = require './db'

people_search = require './search/people'

(require './couch_views/create_views')(db.connect)

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

app.post '/api/register', (req, res)->
  registration.register db.connect(), req, res

app.get '/api/people/search', (req, res)->
  people_search.go db.connect(), req, res

app.get '/api/checkins/search', (req, res)->
  checkins_search.go db.connect(), req, res

app.listen process.env.PORT or 5000

console.log "listening..."
console.log "Settings #{util.inspect app.settings}"
