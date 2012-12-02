(function() {
  var app, connect, cradle, express, registration, sms, util;
  express = require('express');
  util = require('util');
  cradle = require('cradle');
  sms = require('./sms');
  registration = require('./registration');
  connect = function() {
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
    return sms.receive(connect(), req, res);
  });
  app.post('/api/register', function(req, res) {
    return registration.register(connect(), req, res);
  });
  app.listen(process.env.PORT || 5000);
  console.log("listening...");
  console.log("Settings " + (util.inspect(app.settings)));
}).call(this);
