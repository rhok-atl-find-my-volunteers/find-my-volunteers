(function() {
  var app, express;

  express = require('express');

  app = express();

  app.enable('trust proxy');

  app.get('/', function(req, res) {
    return res.send('Hello World!');
  });

  app.listen(3000 || process.env.PORT);

  console.log('listening...');

}).call(this);
