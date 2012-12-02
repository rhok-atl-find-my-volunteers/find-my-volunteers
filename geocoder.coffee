util = require 'util'
geocoder = require 'geocoder'

constructPrefix = (person, address)->
  prefix = ''

  if address.toLowerCase().trim() is 'home'
    prefix = person.volunteerId
  else
    prefix = person.groupId

exports.geocode = (db, person, address, completion)->
  prefix = constructPrefix person, address

  key = (prefix + '_' + address).toLowerCase().trim()

  db.view 'views/aliases', key: key, (err, response)->
    alias = response[0]

    completion alias.value if alias?

    unless alias?
      numberOfWords = address.match(/\S+/g).length

      if numberOfWords > 2
        geocoder.geocode address, (err, data)->
          if not err?
            completion data.results[0].geometry.location
      else
        completion undefined
