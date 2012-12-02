(function() {
  exports.geocode = function(address, completion) {
    var geocoder, util;
    util = require('util');
    geocoder = require('geocoder');
    return geocoder.geocode(address, function(err, data) {
      if (err != null) {
        return console.log(util.inspect(err));
      } else {
        return completion(data.results[0].geometry.location);
      }
    });
  };
}).call(this);
