projection = (c)->
  foo: c.foo

exports.go = (require './define_search').define 'views/checkins_search', projection
