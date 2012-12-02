(function() {
  var adminApp;
  adminApp = angular.module('adminApp', ['ui.directives']);
  adminApp.controller('adminCtrl', function($scope, $http) {
    $scope.searchSubmitted = true;
    $scope.results = [
      {
        name: 'bill',
        volunteerId: '12392',
        groupId: 'cambodia3',
        contact: '(404) 293-9448'
      }
    ];
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
