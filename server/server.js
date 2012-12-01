(function() {
  var app, express;

  express = require('express');

  app = express();

  app.get('/', function(req, res) {
    var body;
    body = 'Hey!';
    res.setHeader('Content-Type', 'text/plain');
    res.setHeader('Content-Length', body.length);
    return res.end(body);
  });

}).call(this);
