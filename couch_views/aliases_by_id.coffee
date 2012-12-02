exports.name = 'aliases_by_id'
exports.map = (doc)->
  if doc._id.match /aliases\//
    groupId = doc.groupId.toLowerCase().trim()
    emit groupId
