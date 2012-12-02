adminApp = angular.module 'adminApp', ['ui.directives', 'appDirectives', 'appServices']

adminApp.controller 'adminCtrl', ($scope, httpMaybe)->

  $scope.searchSubmitted = false
  $scope.people = undefined

  $scope.showCheckinLog = false
  $scope.checkinLog = undefined

  $scope.$watch 'showCheckinLog', (nowShowing)->
    $scope.checkinLog = undefined if !nowShowing

  $scope.searchFoundPeople = ->
    $scope.people?.length > 0

  $scope.hasSearchTerm = ->
    $scope.search?.length > 0

  $scope.submitSearch = ->
    httpMaybe.get('/api/people/search', params:{q: $scope.search}, ifLocal: samplePeople)
      .success (people)->
        $scope.searchSubmitted = true
        $scope.people = people

  $scope.closeCheckinLog = ->
    $scope.showCheckinLog = false

  $scope.closeMap = ->
    $scope.showMap = false

  $scope.showCheckinLogForPerson = (person)->
    httpMaybe.get('/api/checkins/search', params: {q: person.volunteerId}, ifLocal: sampleCheckins)
      .success (checkins)->
        $scope.checkinLog =
          name: person.name
          entries: checkins
        $scope.showCheckinLog = true

  $scope.showMap = undefined

  $scope.showLocation = (entries)->
    $scope.entries = entries
    $scope.showMap = true

  $scope.$watch 'showMap', (showMap)->
    if showMap and $scope.checkinLog?
      $scope.savedCheckinLog = $scope.checkinLog
      $scope.showCheckinLog = false
    else if !showMap and $scope.savedCheckinLog?
      $scope.checkinLog = $scope.savedCheckinLog
      $scope.savedCheckinLog = undefined
      $scope.showCheckinLog = true


samplePeople = [
    {
      name: 'bill'
      volunteerId: '12392'
      groupId: 'cambodia3'
      contact: ['(404) 293-9448', 'person@email.com']
    },
    {
      name: 'mary'
      volunteerId: '29192'
      groupId: 'cambodia3'
      contact: ['(404) 293-9448']
      location: {lat: 39.4958, lng: 92.944}
      site: { lat: 39.48, lng: 39.239, alias: 'Atlanta' }
    }
  ]

sampleCheckins = [
      {
        timestamp: new Date()
        message: "Atlanta"
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 22, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Atlanta"
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 23, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Atlanta"
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 24, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 25, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 26, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 27, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 28, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 29, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 30, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 31, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 32, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 33, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 34, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 35, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 36, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 37, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 38, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 39, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 40, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 41, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 42, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 43, lng: -78.670 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 44, lng: -78.670 }
      }
    ]
