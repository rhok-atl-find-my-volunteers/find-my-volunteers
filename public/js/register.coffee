registerApp = angular.module 'registerApp', []

registerApp.controller 'registerCtrl', ($scope) ->

  $scope.isClean = ->
    angular.equals self.original, $scope.info

  $scope.cancel = ->

  $scope.submit = ->
    if $scope.isClean()
      console.log 'sign up!'
