(function() {
  var app, express;

  express = require('express');

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

  app.get('/api/hello', function(res) {
    return res.send('Hello World!');
  });

  app.listen(process.env.PORT || 3000);

  console.log('listening...');

}).call(this);
