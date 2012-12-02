util = require 'util'

create_views = (db, views...)->
  views_doc =
    language: 'javascript'
    views   : {}

  for view in views
    console.log "Creating view: #{view.name}"
    views_doc.views[view.name] =
      map : view.map.toString()

  db.save '_design/views', views_doc

module.exports = (connect)->
  create_views connect(),
    (require './person_by_phone'),
    (require './person_search'),
    (require './checkins_search'),
    (require './aliases'),
    (require './aliases_by_id')
