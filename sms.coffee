coder = require './geocoder'
util = require 'util'
_ = require 'underscore'
iso8601 = require 'iso8601'

exports.send = (req, res)->
  {message, contacts} = req.body

  for number in contacts
    process.nextTick (number)-> console.log "Send '#{message}' to: #{number}" #sendTo number, message

exports.receive = (db, req, res)->
  message = req.body
  message.timeStamp = iso8601.fromDate new Date

  db.view 'views/person_by_phone', key: (message.From.replace /[^0-9]/, ''), (err, response)->
    person = response[0]?.value
    message = _.extend message, person

    coder.geocode db, person, message.Body, (err, location)->
      if not err?
        message.location = location

        db.save "sms/#{message.SmsSid}", message, (err, response)->
          if not err?
            res.send "<Response><Sms>We have successfully determined your location to be #{util.inspect location}</Sms></Response>"
          else
            res.send '<Response><Sms>We are unable to process your request.</Sms></Response>'

        res.send "<Response><Sms>We have received your request; however we were unable to determine your location.</Sms></Response>" if not location?
      else
        res.send '<Response><Sms>We are unable to process your request.</Sms></Response>'
