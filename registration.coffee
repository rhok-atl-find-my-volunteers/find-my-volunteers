iso8601 = require 'iso8601'
sms = require('./sms')

exports.register = (db, req, res)->
  reg = req.body

  person =
    volunteerId: reg.volunteerId
    name: reg.name
    contact: [reg.phoneNumber]
    groupId: reg.groupId
    timeStamp: iso8601.fromDate new Date

  db.save 'person/' + person.volunteerId, person, (err)->
    res.send 500, util.inspect err if err?
    sms.send {body: 'Thank you for registering. Send your location to this number to check in.', contacts: [person.contact[0]]}
    res.send 204 unless err?
