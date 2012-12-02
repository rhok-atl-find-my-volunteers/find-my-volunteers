(function() {
  var adminApp;

  adminApp = angular.module('adminApp', ['ui.directives']);

  adminApp.controller('adminCtrl', function($scope, $http) {
    $scope.results = [
      {
        name: "Joe Bob",
        volunteerId: "12315123",
        groupId: "Cambodia5",
        contact: "(404) 555 - 1234"
      }, {
        name: "Jane Bob",
        volunteerId: "2394858",
        groupId: "Cambodia5",
        contact: "(404) 555 - 6968"
      }
    ];
    $scope.hasSearchTerm = function() {
      var _ref;
      return ((_ref = $scope.search) != null ? _ref.length : void 0) > 0;
    };
    return $scope.submitSearch = function() {
      return $http.get('/api/query', {
        search: $scope.search
      }).success(function(results) {
        return $scope.results = results;
      });
    };
  });

}).call(this);
