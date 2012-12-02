adminApp = angular.module 'adminApp', ['ui.directives']

adminApp.controller 'adminCtrl', ($scope, $http)->

  #$scope.results = undefined
  #$scope.searchSubmitted = false

  # State after a search
  $scope.searchSubmitted = true
  $scope.results = [
    {name: 'bill', volunteerId: '12392', groupId: 'cambodia3', contact: '(404) 293-9448'}
  ]

  #$scope.checkinLog = undefined
  $scope.checkinLog =
    name: "Billy Bob"
    entries: [
      {
        timestamp: new Date()
        message: "Atlanta"
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lon: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Atlanta"
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lon: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Atlanta"
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lon: 29.38337 }
      }
    ]

  $scope.hasResults = ->
    $scope.results?.length > 0

  $scope.hasSearchTerm = ->
    $scope.search?.length > 0

  $scope.submitSearch = ->
    $http.get('/api/people/search', params: q: $scope.search)
      .success (results)->
        $scope.searchSubmitted = true
        $scope.results = results
