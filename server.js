(function() {
  var app, db, express, registration, sms, util;
  express = require('express');
  util = require('util');
  sms = require('./sms');
  registration = require('./registration');
  db = require('./db');
  (require('./couch_views/create_views'))(db.connect);
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
  app.get('/api/people/search', function(req, res) {
    var query;
    if (req.query.q != null) {
      query = req.query.q.toLowerCase().trim();
      console.log("Searching for People: " + query);
      return db.connect().view('views/person_search', {
        key: query,
        include_docs: true
      }, function(err, data) {
        var item, project;
        if (err != null) {
          res.send(500, util.inspect(err));
        }
        project = function(person) {
          return {
            name: person.name,
            volunteerId: person.volunteerId,
            groupId: person.groupId,
            contact: person.contact
          };
        };
        if (err == null) {
          return res.json((function() {
            var _i, _len, _results;
            _results = [];
            for (_i = 0, _len = data.length; _i < _len; _i++) {
              item = data[_i];
              _results.push(project(item.doc));
            }
            return _results;
          })());
        }
      });
    } else {
      return res.json([]);
    }
  });
  app.listen(process.env.PORT || 5000);
  console.log("listening...");
  console.log("Settings " + (util.inspect(app.settings)));
}).call(this);
