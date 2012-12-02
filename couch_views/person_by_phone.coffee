exports.name = 'person_by_phone'
exports.map = (doc)->
  if doc._id.match /person\//
    d =
      phone      : doc.phoneNumber?.replace(/[^0-9]/g, '')
      groupId    : doc.groupId
      volunteerId: doc.volunteerId
      name       : doc.name

    emit d.phone, d
