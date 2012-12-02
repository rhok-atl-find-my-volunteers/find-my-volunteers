(function() {
  var adminApp;

  adminApp = angular.module('adminApp', ['ui.directives', 'appDirectives']);

  adminApp.controller('adminCtrl', function($scope, $http) {
    $scope.searchSubmitted = true;
    $scope.results = [
      {
        name: 'bill',
        volunteerId: '12392',
        groupId: 'cambodia3',
        contact: ['(404) 293-9448', 'person@email.com']
      }
    ];
    $scope.showCheckinLog = false;
    $scope.checkinLog = void 0;
    $scope.$watch('showCheckinLog', function(newVal, oldVal) {});
    $scope.hasResults = function() {
      var _ref;
      return ((_ref = $scope.results) != null ? _ref.length : void 0) > 0;
    };
    $scope.hasSearchTerm = function() {
      var _ref;
      return ((_ref = $scope.search) != null ? _ref.length : void 0) > 0;
    };
    $scope.submitSearch = function() {
      return $http.get('/api/people/search', {
        params: {
          q: $scope.search
        }
      }).success(function(results) {
        $scope.searchSubmitted = true;
        return $scope.results = results;
      });
    };
    $scope.showCheckinLogForPerson = function(person) {
      return $http.get('/api/checkins/search', {
        params: {
          q: person.volunteerId
        }
      }).success(function(checkins) {
        $scope.checkinLog = {
          name: person.name,
          entries: checkins
        };
        return $scope.showCheckinLog = true;
      });
    };
    return $scope.showLocation = function(entries) {
      return console.log('mapping entries', entries);
    };
  });

}).call(this);
