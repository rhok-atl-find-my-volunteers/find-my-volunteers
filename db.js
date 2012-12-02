(function() {
  var cradle;
  cradle = require('cradle');
  exports.connect = function() {
    var port, prod, url;
    prod = !!process.env.CLOUDANT_URL;
    url = 'http://127.0.0.1';
    if (prod) {
      url = process.env.CLOUDANT_URL;
    }
    port = 5984;
    if (prod) {
      port = 443;
    }
    return (new cradle.Connection(url, port, {
      cache: true,
      raw: false
    })).database('db');
  };
}).call(this);
