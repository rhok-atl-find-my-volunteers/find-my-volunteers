registerApp = angular.module 'registerApp', ['ui.directives']

registerApp.controller 'registerCtrl', ($scope, $http) ->

  $scope.showModal = false;

  $scope.openModal = ->
    $scope.showModal = true

  $scope.closeModal = ->
    $scope.showModal = false

  $scope.isClean = ->
    angular.equals self.original, $scope.info

  $scope.submit = ->
    $http.post '/api/register', $scope.info unless $scope.registrationForm.$invalid
