exports.name = 'aliases'
exports.map = (doc)->
  if doc._id.match /aliases\//
    groupId = doc.groupId.toLowerCase().trim()

    for entry in doc.aliases
      emit groupId + '_' + entry.alias.toLowerCase().trim(), entry.location if entry.location?

  if doc._id.match /person\//
    emit doc.volunteerId + '_home', doc.site if doc.site?
