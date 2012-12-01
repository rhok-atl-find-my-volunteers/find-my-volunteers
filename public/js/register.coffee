registerApp = angular.module 'registerApp', ['ui.directives']

registerApp.controller 'registerCtrl', ($scope) ->

  $scope.showModal = false;

  $scope.openModal = ->
    $scope.showModal = true

  $scope.closeModal = ->
    $scope.showModal = false

  $scope.isClean = ->
    angular.equals self.original, $scope.info

  $scope.submit = ->
    if $scope.isClean()
      console.log 'sign up!'
