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
              'marker'
            ]

            keyDisplay =
              name: 'Name'
              volunteerId: 'Volunteer ID'
              groupId: 'Group ID'
              contact: 'Contact'
              timeStamp: 'Time'
              message: 'Message'

            for entry in entries
              do (entry)->

                location = entry.location || entry.lastKnownLocation

                if location
                  entry.marker = new google.maps.Marker(
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
                      content += "<p class=\"info-window-content\"><strong>#{keyDisplay[key] || key}:</strong> #{value}</p>"

                  entry.marker.infoWindow = new google.maps.InfoWindow(
                    content: content
                  )

                  entry.marker.addListener 'click', ->
                    for innerEntry in entries
                      innerEntry.marker?.infoWindow?.close()
                    entry.marker.infoWindow.open(map, entry.marker)

              (entry)

          , 250)

  .directive 'clickableGoogleMap', ($timeout)->
    restrict: 'A'
    link: (scope, element, attrs)->

      scope.$watch 'showClickableMap', (showMap)->

        if showMap
          $timeout(->
            mapOptions =
              center: new google.maps.LatLng(0, 0)
              zoom: 1
              mapTypeId: google.maps.MapTypeId.ROADMAP

            map = new google.maps.Map(element[0], mapOptions)

            marked = false

            map.addListener 'click', (e)->

              unless marked

                marked = true

                marker = new google.maps.Marker(
                  map: map,
                  position: new google.maps.LatLng(e.latLng.lat(), e.latLng.lng())
                  draggable: true
                )

                scope.newSite.lat = e.latLng.lat()
                scope.newSite.lng = e.latLng.lng()
                scope.$apply()

                marker.addListener 'dragend', (e)->

                  scope.newSite.lat = e.latLng.lat()
                  scope.newSite.lng = e.latLng.lng()
                  scope.$apply()

          , 250)
