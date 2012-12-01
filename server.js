(function() {
  var app, express;

  express = require('express');

  app = express();

  app.enable('trust proxy');

  app.configure(function() {
    app.use(app.router);
    return app.use(express["static"](__dirname + '/public'));
  });

  app.get('/', function(req, res) {
    return res.sendfile(__dirname + '/public/index.html');
  });

  app.listen(3000 || process.env.PORT);

  console.log('listening...');

}).call(this);
