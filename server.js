(function() {
  var app, cradle, express, util;

  express = require('express');

  util = require('util');

  cradle = require('cradle');

  app = express();

  app.enable('trust proxy');

  app.configure(function() {
    app.use(express.logger());
    app.use(app.router);
    return app.use(express.static(__dirname + '/public'));
  });

  app.get('/', function(req, res) {
    return res.sendfile(__dirname + '/public/index.html');
  });

  app.get('/api/hello', function(req, res) {
    var connect, db;
    connect = new cradle.Connection(process.env.CLOUDANT_URL, {
      cache: true,
      raw: false
    });
    db = connect.database('db');
    return db.save('hello', {
      world: 'here!'
    }, function(err) {
      if (err != null) res.send(500, util.inspect(err));
      return res.send('hello world!');
    });
  });

  app.post('/api/sms/receive', function(req, res) {
    console.log(req);
    return res.send("<Response><Sms>Got this:" + req.Body + " from " + req.FromCity + "</Sms></Response>");
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
