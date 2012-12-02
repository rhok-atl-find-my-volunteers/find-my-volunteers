(function() {
  var registerApp;
  registerApp = angular.module('registerApp', ['ui.directives']);
  registerApp.controller('registerCtrl', function($scope, $http) {
    $scope.showModal = false;
    $scope.formSubmitted = false;
    $scope.openModal = function() {
      $scope.clear();
      return $scope.showModal = true;
    };
    $scope.closeModal = function() {
      $scope.clear();
      return $scope.showModal = false;
    };
    $scope.isClean = function() {
      return angular.equals(self.original, $scope.info);
    };
    $scope.clear = function() {
      return $scope.info = {};
    };
    return $scope.submit = function() {
      if (!$scope.registrationForm.$invalid) {
        return $http.post('/api/register', $scope.info).success(function() {
          $scope.showModal = false;
          $scope.formSubmitted = true;
          return $scope.clear();
        });
      }
    };
  });
}).call(this);
