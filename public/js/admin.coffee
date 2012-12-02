adminApp = angular.module 'adminApp', ['ui.directives']

adminApp.controller 'adminCtrl', ($scope, $http)->

  $scope.results = [
    {name: "Joe Bob", volunteerId: "12315123", groupId: "Cambodia5", contact: "(404) 555 - 1234"},
    {name: "Jane Bob", volunteerId: "2394858", groupId: "Cambodia5", contact: "(404) 555 - 6968"}
  ]

  $scope.hasSearchTerm = ->
    $scope.search?.length > 0

  $scope.submitSearch = ->
    $http.get('/api/query', search: $scope.search)
      .success (results)->
        $scope.results = results
