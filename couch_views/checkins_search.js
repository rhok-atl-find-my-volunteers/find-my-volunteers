(function() {

  exports.name = 'checkins_search';

  exports.map = function(doc) {
    if (doc._id.match(/sms\//)) return emit.doc.volunteerId;
  };

}).call(this);
