exports.name = 'checkins_search'
exports.map = (doc)->
  if doc._id.match /sms\//
    emit doc.volunteerId
