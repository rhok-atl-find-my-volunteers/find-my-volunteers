(function() {
  var app, connect, cradle, express, util;

  express = require('express');

  util = require('util');

  cradle = require('cradle');

  connect = function() {
    var port, prod, url;
    prod = !!process.env.CLOUDANT_URL;
    url = 'http://127.0.0.1';
    if (prod) url = process.env.CLOUDANT_URL;
    port = 5984;
    if (prod) port = 443;
    return (new cradle.Connection(url, port, {
      cache: true,
      raw: false
    })).database('db');
  };

  app = express();

  app.enable('trust proxy');

  app.configure(function() {
    app.use(express.logger());
    app.use(express.bodyParser());
    app.use(app.router);
    return app.use(express["static"](__dirname + '/public'));
  });

  app.get('/', function(req, res) {
    return res.sendfile(__dirname + '/public/index.html');
  });

  app.get('/api/hello', function(req, res) {
    var db;
    db = connect();
    return db.save('hello', {
      world: 'here!'
    }, function(err, response) {
      if (err != null) {
        res.send(500, util.inspect(err));
      }
      return res.send('hello world!');
    });
  });

  app.post('/api/sms/receive', function(req, res) {
    var db;
    db = connect();
    return db.save("/" + req.body.SmsSid, req.body, function(err, response) {
      if (err != null) {
        return res.send('<Response><Sms>We are unable to process your request.</Sms></Response>');
      } else {
        return res.send("<Response><Sms>We have received your request.</Sms></Response>");
      }
    });
  });

  app.post('/api/register', function(req, res) {
    var person, reg;
    reg = req.body;
    person = {
      id: reg.vid,
      name: reg.name,
      phone: reg.phone,
      group: reg.group
    };
    return res.send(204);
  });

  app.listen(process.env.PORT || 5000);

  console.log("listening...");

  console.log("Settings " + (util.inspect(app.settings)));

}).call(this);
