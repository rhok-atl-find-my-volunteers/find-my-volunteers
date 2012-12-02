adminApp = angular.module 'adminApp', ['ui.directives']

adminApp.controller 'adminCtrl', ($scope, $http)->

  #$scope.results = undefined
  #$scope.searchSubmitted = false

  # State after a search
  $scope.searchSubmitted = true
  $scope.results = [
    {name: 'bill', volunteerId: '12392', groupId: 'cambodia3', contact: '(404) 293-9448'}
  ]

  $scope.checkinLog = undefined

  $scope.hasResults = ->
    $scope.results?.length > 0

  $scope.hasSearchTerm = ->
    $scope.search?.length > 0

  $scope.submitSearch = ->
    $http.get('/api/people/search', params: q: $scope.search)
      .success (results)->
        $scope.searchSubmitted = true
        $scope.results = results
