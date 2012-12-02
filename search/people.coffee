projection = (person)->
  name: person.name
  volunteerId: person.volunteerId
  groupId: person.groupId
  contact: person.contact
  lastKnownLocation: person.lastKnownLocation

exports.go = (require './define_search').define 'views/person_search', projection
