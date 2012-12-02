(function() {
  var app, db, express, registration, sms, util;
  express = require('express');
  util = require('util');
  sms = require('./sms');
  registration = require('./registration');
  db = require('./db');
  app = express();
  app.enable('trust proxy');
  app.configure(function() {
    app.use(express.logger());
    app.use(express.bodyParser());
    app.use(app.router);
    return app.use(express.static(__dirname + '/public'));
  });
  app.get('/', function(req, res) {
    return res.sendfile(__dirname + '/public/index.html');
  });
  app.post('/api/sms/receive', function(req, res) {
    return sms.receive(db.connect(), req, res);
  });
  app.post('/api/register', function(req, res) {
    return registration.register(db.connect(), req, res);
  });
  app.listen(process.env.PORT || 5000);
  console.log("listening...");
  console.log("Settings " + (util.inspect(app.settings)));
}).call(this);
