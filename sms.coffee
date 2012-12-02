exports.receive = (db, req, res) ->
  db.save "sms/#{req.body.SmsSid}", req.body, (err, response)->
    if err?
      console.log util.inspect err
      res.send '<Response><Sms>We are unable to process your request.</Sms></Response>'
    else
      res.send "<Response><Sms>We have received your request.</Sms></Response>"