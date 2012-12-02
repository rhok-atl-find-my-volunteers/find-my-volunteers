(function() {
  exports.name = 'person_by_phone';
  exports.map = function(doc) {
    var d, _ref, _ref2, _ref3;
    if (doc._id.match(/person\//)) {
      d = {
        phone: (_ref = doc.phoneNumber) != null ? _ref.replace(/[^0-9]/g, '') : void 0,
        groupId: (_ref2 = doc.groupId) != null ? _ref2.toLowerCase() : void 0,
        volunteerId: doc.volunteerId,
        name: (_ref3 = doc.name) != null ? _ref3.toLowerCase() : void 0
      };
      return emit(d.phone, d);
    }
  };
}).call(this);
