(function() {
  exports.receive = function(db, req, res) {
    var util;
    util = require('util');
    return db.save("sms/" + req.body.SmsSid, req.body, function(err, response) {
      if (err != null) {
        console.log(util.inspect(err));
        return res.send('<Response><Sms>We are unable to process your request.</Sms></Response>');
      } else {
        require('./geocoder').geocode(req.body.Body, function(location) {
          return console.log(util.inspect(location));
        });
        return res.send("<Response><Sms>We have received your request.</Sms></Response>");
      }
    });
  };
}).call(this);
