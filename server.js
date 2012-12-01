(function() {
  var app, express, util;

  express = require('express');

  util = require('util');

  app = express();

  app.enable('trust proxy');

  app.configure(function() {
    app.use(express.logger());
    app.use(app.router);
    return app.use(express["static"](__dirname + '/public'));
  });

  app.get('/', function(req, res) {
    return res.sendfile(__dirname + '/public/index.html');
  });

  app.get('/api/hello', function(req, res) {
    return res.send('hello world!');
  });

  app.post('/api/sms/receive', function(req, res) {
    console.log(req);
    return res.send("From City " + req.FromCity);
  });

  app.post('/api/register', function(req, res) {
    return res.send(204);
  });

  app.listen(process.env.PORT || 5000);

  console.log("listening...");

  console.log("Settings " + (util.inspect(app.settings)));

}).call(this);
