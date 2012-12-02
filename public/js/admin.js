(function() {
  var adminApp;
  adminApp = angular.module('adminApp', ['ui.directives']);

  adminApp = angular.module('adminApp', ['ui.directives', 'appDirectives']);

  adminApp = angular.module('adminApp', ['ui.directives']);
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
    $scope.showCheckinLog = true;
    $scope.checkinLog = {
      name: "Billy Bob",
      entries: [
        {
          timestamp: new Date(),
          message: "Atlanta"
        }, {
          timestamp: new Date(),
          message: "Macon",
          location: {
            lat: 293.4949,
            lon: 29.38337
          }
        }, {
          timestamp: new Date(),
          message: "Atlanta"
        }, {
          timestamp: new Date(),
          message: "Macon",
          location: {
            lat: 293.4949,
            lon: 29.38337
          }
        }, {
          timestamp: new Date(),
          message: "Atlanta"
        }, {
          timestamp: new Date(),
          message: "Macon",
          location: {
            lat: 293.4949,
            lon: 29.38337
          }
        }
      ]
    };
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
    return $scope.showLocation = function(entries) {
      return console.log('mapping entries', entries);
    };
  });
}).call(this);
