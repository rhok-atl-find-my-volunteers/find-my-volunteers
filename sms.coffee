coder = require './geocoder'
util = require 'util'
_ = require 'underscore'
iso8601 = require 'iso8601'

exports.receive = (db, req, res)->
  message = req.body
  message.timeStamp = iso8601.fromDate new Date

  coder.geocode message.Body, (location)->
    message.location = location
    db.view 'views/person_by_phone', key: (message.From.replace /[^0-9]/, ''), (err, response)->
      message = _.extend message, response[0]?.value

      db.save "sms/#{message.SmsSid}", message, (err, response)->
        if err?
          res.send '<Response><Sms>We are unable to process your request.</Sms></Response>'
        else
          res.send "<Response><Sms>We have received your request.</Sms></Response>"
