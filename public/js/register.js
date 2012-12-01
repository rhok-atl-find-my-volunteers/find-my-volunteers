(function() {
  var registerApp;

  registerApp = angular.module('registerApp', []);

  registerApp.controller('registerCtrl', function($scope) {
    $scope.isClean = function() {
      return angular.equals(self.original, $scope.info);
    };
    $scope.cancel = function() {};
    return $scope.submit = function() {
      if ($scope.isClean()) {
        return console.log('sign up!');
      }
    };
  });

}).call(this);
