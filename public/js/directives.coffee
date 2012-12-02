angular.module('appDirectives', [])

  .directive 'locationTitle', ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      if scope.entry?.location? or scope.person?.location?
        element.addClass 'located'
      else
        element.attr 'title', 'No Location Information'

  .directive 'googleMap', ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      scope.$watch 'showMap', (showMap) ->
        if showMap

          setTimeout( ->
            element.html ''

            locations = $.map scope.entries, (entry) ->
              entry.location

            mapOptions =
              center: new google.maps.LatLng(locations[0].lat, locations[0].lng)
              zoom: 15
              mapTypeId: google.maps.MapTypeId.ROADMAP

            map = new google.maps.Map( element[0], mapOptions )

            for location in locations
              new google.maps.Marker(
                map: map,
                position: new google.maps.LatLng(location.lat, location.lng)
              )

          , 250)
