exports.register = (db, req, res) ->
  reg = req.body

  person =
    id: reg.volunteerId
    name: reg.name
    phone: reg.phoneNumber
    group: reg.groupId

  db = connect()
  db.save 'person/' + person.id, person, (err)->
    res.send 500, util.inspect err if err
    res.send 204 unless err