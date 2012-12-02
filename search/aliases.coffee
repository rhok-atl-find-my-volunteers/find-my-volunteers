projection = (a)->
  a

iterator = (list, projection)->
  return [] unless list[0]?
  (projection alias for alias in list[0].doc.aliases)

exports.go = (require './define_search').define 'views/aliases_by_id', projection, 'groupId', iterator
