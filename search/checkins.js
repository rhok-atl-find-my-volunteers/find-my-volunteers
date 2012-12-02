(function() {
  var projection;

  projection = function(c) {
    return {
      foo: c.foo
    };
  };

  exports.go = (require('./define_search')).define('views/checkins_search', projection);

}).call(this);
