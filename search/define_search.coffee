exports.define = (view, projection)->
  (db, req, res)->
    if req.query.q?
      query = req.query.q.toLowerCase().trim()
      console.log "Searching #{view}: #{query}"

      db.view view, key: query, include_docs: yes, (err, data)->
        res.send 500, util.inspect err if err?
        res.json (projection item.doc for item in data) unless err?
    else
      res.json []
