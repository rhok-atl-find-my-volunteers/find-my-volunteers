angular.module('appDirectives', [])
  .directive 'locationTitle', ->
    restrict: 'A'
    link: (scope, element, attrs)->
      if scope.entry?.location? or scope.person?.location?
        element.addClass 'located'
      else
        element.attr 'title', 'No Location Information'
