projection = (c)->
  message: c.Body
  from: c.From
  timeStamp: c.timeStamp

exports.go = (require './define_search').define 'views/checkins_search', projection
