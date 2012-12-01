(function() {
  var registerApp;

  registerApp = angular.module('registerApp', ['ui.directives']);

  registerApp.controller('registerCtrl', function($scope, $http) {
    $scope.showModal = false;
    $scope.formSubmitted = false;
    $scope.openModal = function() {
      return $scope.showModal = true;
    };
    $scope.closeModal = function() {
      return $scope.showModal = false;
    };
    $scope.isClean = function() {
      return angular.equals(self.original, $scope.info);
    };
    return $scope.submit = function() {
      if (!$scope.registrationForm.$invalid) {
        return $http.post('/api/register', $scope.info).success(function() {
          $scope.showModal = false;
          return $scope.formSubmitted = true;
        });
      }
    };
  });

}).call(this);
