angular.module('appDirectives', [])

  .directive 'locationTitle', ->
    restrict: 'A'
    link: (scope, element, attrs)->
      if scope.entry?.location? or scope.person?.lastKnownLocation?
        element.addClass 'located'
      else
        element.attr 'title', 'No Location Information'

  .directive 'googleMap', ($filter)->
    restrict: 'A'
    link: (scope, element, attrs)->
      scope.$watch 'showMap', (showMap)->
        if showMap

          setTimeout(->
            element.html ''

            entries = scope.entries

            i = 0
            while entries[i] and !centerLocation
              centerLocation = entries[i].location || entries[i].lastKnownLocation
              i++

            mapOptions =
              center: new google.maps.LatLng(centerLocation.lat, centerLocation.lng)
              zoom: if entries.length > 1 then 5 else 10
              mapTypeId: google.maps.MapTypeId.ROADMAP

            map = new google.maps.Map(element[0], mapOptions)

            ignoreKeys = [
              'location'
              '$$hashKey'
              'site'
            ]

            for entry in entries
              location = entry.location || entry.lastKnownLocation

              if location
                marker = new google.maps.Marker(
                  map: map,
                  position: new google.maps.LatLng(location.lat, location.lng)
                )

                content = ''

                for own key, value of entry
                  if $.inArray(key, ignoreKeys) == -1
                    if key == 'lastKnownLocation'
                      key = 'timeStamp'
                      value = value.timeStamp
                    if key == 'timeStamp'
                      value = $filter('date')(value, 'short')
                    content += "<p>#{key}: #{value}</p>"

                marker.addListener 'click', ->
                  new google.maps.InfoWindow(
                    content: content
                  ).open(map, marker)

          , 250)
