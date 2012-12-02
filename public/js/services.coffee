angular.module('appServices', [])
  .factory 'httpMaybe', ($http)->
      if window.location.href.indexOf('local=true') > -1
        return {
          get: (url, opts)->
            success: (fn)-> fn opts.ifLocal
            then: (fn)-> fn opts.ifLocal
        }
      else
        return $http
