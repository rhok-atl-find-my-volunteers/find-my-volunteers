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
    if err?
      completion err, undefined
      return

    alias = response[0]

    if alias?
      completion undefined, alias.value
      return
  
    numberOfWords = address.match(/\S+/g).length

    if numberOfWords < 3
      completion undefined, undefined
      return

    geocoder.geocode address, (err, data)->
      if err?
        completion err, undefined
        return

      completion undefined, data.results[0].geometry.location