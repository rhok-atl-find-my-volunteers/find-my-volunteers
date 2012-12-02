registerApp = angular.module 'registerApp', ['ui.directives', 'appServices']

registerApp.controller 'registerCtrl', ($scope, httpMaybe)->

  $scope.showModal = false
  $scope.formSubmitted = false

  $scope.openModal = ->
    $scope.clear()
    $scope.showModal = true

  $scope.closeModal = ->
    $scope.clear()
    $scope.showModal = false

  $scope.isClean = ->
    angular.equals self.original, $scope.info

  $scope.clear = ->
    $scope.info = {}

  $scope.submit = ->
    unless $scope.registrationForm.$invalid
      httpMaybe.post('/api/register', $scope.info)
       .success ->
          $scope.showModal = false
          $scope.formSubmitted = true
          $scope.clear()
