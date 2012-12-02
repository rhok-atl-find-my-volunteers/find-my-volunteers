(function() {
  var projection;

  projection = function(person) {
    return {
      name: person.name,
      volunteerId: person.volunteerId,
      groupId: person.groupId,
      contact: person.contact
    };
  };

  exports.go = (require('./define_search')).define('views/person_search', projection);

}).call(this);
