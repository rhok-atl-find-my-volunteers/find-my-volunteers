util = require 'util'

exports.set_post = (db, req, res)->
  {alias, lat, lng} = req.body
  personId = req.params.id

  db.get "person/#{personId}", (err, doc)->
    if err?
      res.send 500, util.inspect err if err?
      return if err?

    doc.site =
      lat: lat
      lng: lng
      alias: alias

    db.save "person/#{personId}", doc, (err, doc)->
      res.send 500, util.inspect err if err?
      return if err?

      res.send 204
