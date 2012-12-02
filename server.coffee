express = require 'express'
util = require 'util'
sms = require './sms'
registration = require './registration'
db = require './db'

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
  if req.query.q?
    query = req.query.q.toLowerCase().trim()
    console.log "Searching for People: #{query}"

    db.connect().view 'views/person_search', key: query, include_docs: yes, (err, data)->
      res.send 500, util.inspect err if err?

      project = (person)->
        name: person.name
        volunteerId: person.volunteerId
        groupId: person.groupId
        contact: person.contact

      res.json (project item.doc for item in data) unless err?
  else
    res.json []

app.listen process.env.PORT or 5000

console.log "listening..."
console.log "Settings #{util.inspect app.settings}"
