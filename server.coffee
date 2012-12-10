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

app.listen process.env.PORT or 5000

console.log "listening..."
