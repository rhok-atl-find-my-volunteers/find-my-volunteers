(function() {
  exports.register = function(db, req, res) {
    var person, reg;
    reg = req.body;
    person = {
      volunteerId: reg.volunteerId,
      name: reg.name,
      contact: [reg.phoneNumber],
      groupId: reg.groupId
    };
    return db.save('person/' + person.volunteerId, person, function(err) {
      if (err != null) {
        res.send(500, util.inspect(err));
      }
      if (err == null) {
        return res.send(204);
      }
    });
  };
}).call(this);
