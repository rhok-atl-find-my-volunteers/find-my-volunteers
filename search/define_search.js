(function() {

  exports.define = function(view, projection) {
    return function(db, req, res) {
      var query;
      if (req.query.q != null) {
        query = req.query.q.toLowerCase().trim();
        console.log("Searching " + view + ": " + query);
        return db.view(view, {
          key: query,
          include_docs: true
        }, function(err, data) {
          var item;
          if (err != null) res.send(500, util.inspect(err));
          if (err == null) {
            return res.json((function() {
              var _i, _len, _results;
              _results = [];
              for (_i = 0, _len = data.length; _i < _len; _i++) {
                item = data[_i];
                _results.push(projection(item.doc));
              }
              return _results;
            })());
          }
        });
      } else {
        return res.json([]);
      }
    };
  };

}).call(this);
