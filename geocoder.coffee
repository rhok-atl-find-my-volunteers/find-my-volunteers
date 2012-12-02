util = require 'util'
geocoder = require 'geocoder'
iso8601 = require 'iso8601'

constructPrefix = (personData, address)->
  prefix = ''

  if address.toLowerCase().trim() is 'home'
    prefix = personData.volunteerId
  else
    prefix = personData.groupId

updatePersonLastKnownLocation = (db, personData, location) ->
  person = db.get "person/#{personData.volunteerId}", (err, doc) ->
    if doc?
      doc.lastKnownLocation = 
        lat: location.lat
        lng: location.lng
        timeStamp: iso8601.fromDate new Date
      db.save "person/#{personData.volunteerId}", doc

exports.geocode = (db, personData, address, completion)->
  prefix = constructPrefix personData, address

  key = (prefix + '_' + address).toLowerCase().trim()

  db.view 'views/aliases', key: key, (err, response)->
    if err?
      completion err, undefined
      return

    alias = response[0]

    if alias?
      location = alias.value

      if location?
        completion undefined, location
        updatePersonLastKnownLocation db, personData, location
    else
      numberOfWords = address.match(/\S+/g).length

      if numberOfWords < 3
        completion undefined, undefined
        return

      geocoder.geocode address, (err, data)->
        if err?
          completion err, undefined
          return

        location = data.results[0].geometry.location

        if location?
          completion undefined, location
          updatePersonLastKnownLocation db, personData, location