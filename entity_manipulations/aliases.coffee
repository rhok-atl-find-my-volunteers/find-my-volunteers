util = require 'util'

exports.add = (db, req, res)->
  {groupId, alias, lat, lng} = req.body

  db.get "aliases/#{groupId}", (err, doc)->
    if err?
      if err.reason is 'missing'
        doc = doc or { groupId: groupId, aliases: [] }
      else
        res.send 500, util.inspect err if err?
        return if err?

    doc.aliases.push alias: alias, location: {lat: lat, lng: lng}

    db.save "aliases/#{groupId}", doc, (err, doc)->
      res.send 500, util.inspect err if err?
      return if err?

      res.send 204
