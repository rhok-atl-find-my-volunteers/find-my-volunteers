default_iterator = (list, projection)-> (projection item.doc for item in list)

exports.define = (view, projection, param='q', iterator = default_iterator)->
  (db, req, res)->
    if req.query[param]?
      query = req.query[param].toLowerCase().trim()
      console.log "Searching #{view}: #{query}"

      db.view view, key: query, include_docs: yes, (err, data)->
        res.send 500, util.inspect err if err?
        res.json (iterator data, projection) unless err?
    else
      res.json []
