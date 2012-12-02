(function() {
  exports.name = 'person_by_phone';
  exports.map = function(doc) {
    var d, _ref;
    if (doc._id.match(/person\//)) {
      d = {
        phone: (_ref = doc.phoneNumber) != null ? _ref.replace(/[^0-9]/g, '') : void 0,
        groupId: doc.groupId,
        volunteerId: doc.volunteerId,
        name: doc.name
      };
      return emit(d.phone, d);
    }
  };
}).call(this);
