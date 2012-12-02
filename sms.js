(function() {

  exports.receive = function(db, req, res) {
    return db.save("sms/" + req.body.SmsSid, req.body, function(err, response) {
      if (err != null) {
        console.log(util.inspect(err));
        return res.send('<Response><Sms>We are unable to process your request.</Sms></Response>');
      } else {
        return res.send("<Response><Sms>We have received your request.</Sms></Response>");
      }
    });
  };

}).call(this);
