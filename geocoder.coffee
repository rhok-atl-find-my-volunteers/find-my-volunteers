util = require 'util'
geocoder = require 'geocoder'

constructPrefix = (person, address) ->
  prefix = ''

  if address.toLowerCase().trim() is 'home'
    prefix = person.volunteerId
  else
	prefix = person.groupId

exports.geocode = (db, person, address, completion) ->
  prefix = constructPrefix person, address
  console.log util.inspect prefix

  key = (prefix + '_' + address).toLowerCase().trim()
  console.log util.inspect key

  db.view 'views/aliases', key: key, (err, response)->
	alias = response[0]
	console.log util.inspect alias

	completion alias.value if alias?

	unless alias?
	  geocoder.geocode address, (err, data) ->	  	
	  	console.log util.inspect err if err?
	  	  
	  	if not err?
	  	  completion data.results[0].geometry.location
	  	  console.log util.inspect data if data?