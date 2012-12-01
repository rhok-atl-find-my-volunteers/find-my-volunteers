express = require 'express'
util = require 'util'
cradle = require 'cradle'

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
  connect = new cradle.Connection process.env.CLOUDANT_URL, {
    cache: true
    raw: false
  }
  db = connect.database 'db'

  db.save 'hello', world: 'here!', (err)->
    res.send 500, util.inspect err if err?
    res.send 'hello world!'

app.post '/api/sms/receive', (req, res)->
  console.log req
  res.send "<Response><Sms>Got this:#{req.Body} from #{req.FromCity}</Sms></Response>"

app.post '/api/register', (req, res)->
  reg = req.body

  person =
    id: reg.vid
    name: reg.name
    phone: reg.phone
    group: reg.group

  res.send 204

app.listen process.env.PORT or 5000

console.log "listening..."
console.log "Settings #{util.inspect app.settings}"
