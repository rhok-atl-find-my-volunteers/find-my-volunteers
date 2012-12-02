(function() {
  exports.register = function(db, req, res) {
    var person, reg;
    reg = req.body;
    person = {
      id: reg.volunteerId,
      name: reg.name,
      phone: reg.phoneNumber,
      group: reg.groupId
    };
    db = connect();
    return db.save('person/' + person.id, person, function(err) {
      if (err) {
        res.send(500, util.inspect(err));
      }
      if (!err) {
        return res.send(204);
      }
    });
  };
}).call(this);
