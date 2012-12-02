exports.name = 'person_search'
exports.map = (doc)->
  if doc._id.match /person\//
    emit doc.volunteerId
    emit doc.name?.toLowerCase()
    emit doc.groupId?.toLowerCase()
