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
      .success (results) ->
        $scope.searchSubmitted = true
        $scope.results = results

  $scope.mapLocations = []

  $scope.mapLocations = [
    { lat: 35.784, lng: -78.670 }
    { lat: 38.784, lng: -80.670 }
    { lat: 33.784, lng: -75.670 }
    { lat: 32.784, lng: -77.670 }
  ]

  $scope.mapOptions =
    center: new google.maps.LatLng($scope.mapLocations[0].lat, $scope.mapLocations[0].lng)
    zoom: 15
    mapTypeId: google.maps.MapTypeId.ROADMAP

  $scope.showMap = false

  $scope.openMap = ->

    $scope.showMap = true

    for mapLoc in $scope.mapLocations
      new google.maps.Marker
        map: $scope.checkinMap
        position: new google.maps.LatLng(mapLoc.lat, mapLoc.lng)
