exports.register = (db, req, res)->
  reg = req.body

  person =
    volunteerId: reg.volunteerId
    name: reg.name
    contact: [reg.phoneNumber]
    groupId: reg.groupId

  db.save 'person/' + person.volunteerId, person, (err)->
    res.send 500, util.inspect err if err?
    res.send 204 unless err?
