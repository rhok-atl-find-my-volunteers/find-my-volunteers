coder = require './geocoder'
util = require 'util'
_ = require 'underscore'

exports.receive = (db, req, res)->
  message = req.body

  coder.geocode message.Body, (location)->
    message.location = location
    db.view 'views/person_by_phone', key: (message.From.replace /[^0-9]/, ''), (err, response)->
      message = _.extend message, response[0]?.value

      db.save "sms/#{message.SmsSid}", message, (err, response)->
        if err?
          res.send '<Response><Sms>We are unable to process your request.</Sms></Response>'
        else
          res.send "<Response><Sms>We have received your request.</Sms></Response>"
