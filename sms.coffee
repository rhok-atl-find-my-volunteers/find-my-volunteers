coder = require './geocoder'
util = require 'util'
_ = require 'underscore'
iso8601 = require 'iso8601'

exports.send = (message)->
  for number in message.contacts
    do (number)->
      process.nextTick ()->
        https = require('https')

        post_data = "From=14042366136&To=#{number}&Body=#{message.body}"

        options = 
          host: 'api.twilio.com'
          path: '/2010-04-01/Accounts/AC8f97974845b5c5f464d912ea9873298f/SMS/Messages.json'
          method: 'POST'
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Content-Length': post_data.length,
            'Authorization': 'Basic ' + new Buffer('AC8f97974845b5c5f464d912ea9873298f' + ':' + '137e7c717ada7e9f06d8ab55e2927af0').toString('base64')
          }

        request = https.request options, (response) ->
          str = ''
          response.on 'data', (chunk) -> str += chunk

          response.on 'end', () ->
            console.log util.inspect str

        request.write post_data
        request.end
  return true

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