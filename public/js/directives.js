(function() {

  angular.module('appDirectives', []).directive('locationTitle', function() {
    return {
      restrict: 'A',
      link: function(scope, element, attrs) {
        if (scope.entry.location != null) {
          return element.addClass('located');
        } else {
          return element.attr('title', 'No Location Information');
        }
      }
    };
  });

}).call(this);
