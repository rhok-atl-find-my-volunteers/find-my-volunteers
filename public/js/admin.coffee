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

  $scope.showCheckinLogForPerson = (person)->
    httpMaybe.get('/api/checkins/search', params: {q: person.volunteerId}, ifLocal: sampleCheckins)
      .success (checkins)->
        $scope.checkinLog =
          name: person.name
          entries: checkins
        $scope.showCheckinLog = true

  $scope.showMap = false

  $scope.showLocation = (entries)->
    console.log 'mapping entries', entries
    $scope.showMap = true


samplePeople = [
    {name: 'bill', volunteerId: '12392', groupId: 'cambodia3', contact: ['(404) 293-9448', 'person@email.com']}
  ]

sampleCheckins = [
      {
        timestamp: new Date()
        message: "Atlanta"
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Atlanta"
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Atlanta"
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      },
      {
        timestamp: new Date()
        message: "Macon"
        location: { lat: 293.4949, lng: 29.38337 }
      }
    ]
