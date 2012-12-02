projection = (c)->
  message: c.Body
  from: c.From
  timeStamp: c.timeStamp
  location: c.location

exports.go = (require './define_search').define 'views/checkins_search', projection
