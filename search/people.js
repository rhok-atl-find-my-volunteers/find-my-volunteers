(function() {

  exports.go = function(db, req, res) {
    var query;
    if (req.query.q != null) {
      query = req.query.q.toLowerCase().trim();
      console.log("Searching for People: " + query);
      return db.view('views/person_search', {
        key: query,
        include_docs: true
      }, function(err, data) {
        var item, project;
        if (err != null) res.send(500, util.inspect(err));
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
  };

}).call(this);
