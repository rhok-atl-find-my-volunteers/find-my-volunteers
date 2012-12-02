projection = (person)->
  name: person.name
  volunteerId: person.volunteerId
  groupId: person.groupId
  contact: person.contact
  lastKnownLocation: person.lastKnownLocation
  site: person.site

exports.go = (require './define_search').define 'views/person_search', projection
