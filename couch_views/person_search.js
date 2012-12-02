(function() {
  exports.name = 'person_search';
  exports.map = function(doc) {
    var _ref, _ref2;
    if (doc._id.match(/person\//)) {
      emit(doc.volunteerId);
      emit((_ref = doc.name) != null ? _ref.toLowerCase() : void 0);
      return emit((_ref2 = doc.groupId) != null ? _ref2.toLowerCase() : void 0);
    }
  };
}).call(this);
