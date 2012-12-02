exports.geocode = (address, completion) ->
	util = require 'util'
	geocoder = require 'geocoder'

	geocoder.geocode address, (err, data) ->
  	  if err?
  	    console.log util.inspect err
  	  else
  	    completion data.results[0].geometry.location