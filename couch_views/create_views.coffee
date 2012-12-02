create_views = (db, views...)->
  views_doc =
    language: 'javascript'
    views   : {}

  for view in views
    views_doc.views[view.name] =
      map : view.map.toString()

  db.save '_design/views', views_doc

module.exports = (connect)->
  create_views connect(), (require './person_by_phone')
