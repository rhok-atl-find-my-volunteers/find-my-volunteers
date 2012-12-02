(function() {
  var adminApp;

  adminApp = angular.module('adminApp', ['ui.directives']);

  adminApp.controller('adminCtrl', function($scope, $http) {
    $scope.results = void 0;
    $scope.searchSubmitted = false;
    $scope.checkinLog = void 0;
    $scope.showCheckinLog = void 0;
    $scope.hasResults = function() {
      var _ref;
      return ((_ref = $scope.results) != null ? _ref.length : void 0) > 0;
    };
    $scope.hasSearchTerm = function() {
      var _ref;
      return ((_ref = $scope.search) != null ? _ref.length : void 0) > 0;
    };
    return $scope.submitSearch = function() {
      return $http.get('/api/people/search', {
        params: {
          q: $scope.search
        }
      }).success(function(results) {
        $scope.searchSubmitted = true;
        return $scope.results = results;
      });
    };
  });

}).call(this);
