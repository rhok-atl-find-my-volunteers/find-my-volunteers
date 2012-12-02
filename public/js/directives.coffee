angular.module('appDirectives', [])
  .directive 'locationTitle', ->
    restrict: 'A'
    link: (scope, element, attrs)->
      if scope.entry.location?
        element.addClass 'located'
      else
        element.attr 'title', 'No Location Information'
