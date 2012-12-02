registerApp = angular.module 'registerApp', ['ui.directives']

registerApp.controller 'registerCtrl', ($scope, $http)->

  $scope.showModal = false
  $scope.formSubmitted = false

  $scope.openModal = ->
    $scope.showModal = true

  $scope.closeModal = ->
    $scope.showModal = false

  $scope.isClean = ->
    angular.equals self.original, $scope.info

  $scope.clear = ->
    $scope.info = {}

  $scope.submit = ->
    unless $scope.registrationForm.$invalid
      $http.post('/api/register', $scope.info)
       .success ->
          $scope.showModal = false
          $scope.formSubmitted = true
          $scope.clear()
