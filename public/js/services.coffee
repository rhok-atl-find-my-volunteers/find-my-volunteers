angular.module('appServices', [])
  .factory 'httpMaybe', ($http)->
      if window.location.href.indexOf('local=true') > -1
        return {
          get: (url, opts)->
            console.log "[GET] ", url, opts
            success: (fn)-> fn opts.ifLocal
            then: (fn)-> fn opts.ifLocal
          post: (url, data)->
            console.log "[POST] ", url, data
            success: (fn)-> fn()
            then: (fn)-> fn()

        }
      else
        return $http
