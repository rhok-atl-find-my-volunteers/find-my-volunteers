exports.name = 'person_by_phone'
exports.map = (doc)->
  if doc._id.match /person\//
    for num in doc.contact
      phone = num.replace(/[^0-9]/g, '')
      d =
        groupId    : doc.groupId?.toLowerCase()
        volunteerId: doc.volunteerId
        name       : doc.name?.toLowerCase()

      emit phone, d
