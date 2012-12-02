exports.receive = (db, req, res) ->
  util = require 'util'
  
  db.save "sms/#{req.body.SmsSid}", req.body, (err, response)->
    if err?
      console.log util.inspect err
      res.send '<Response><Sms>We are unable to process your request.</Sms></Response>'
    else
      require('./geocoder').geocode req.body.Body, (location) ->
      	# todo: insert resulting geocoded location data in db
      	console.log util.inspect location

      res.send "<Response><Sms>We have received your request.</Sms></Response>"