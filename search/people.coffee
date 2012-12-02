exports.go = (db, req, res)->
  if req.query.q?
    query = req.query.q.toLowerCase().trim()
    console.log "Searching for People: #{query}"

    db.view 'views/person_search', key: query, include_docs: yes, (err, data)->
      res.send 500, util.inspect err if err?

      project = (person)->
        name: person.name
        volunteerId: person.volunteerId
        groupId: person.groupId
        contact: person.contact

      res.json (project item.doc for item in data) unless err?
  else
    res.json []
