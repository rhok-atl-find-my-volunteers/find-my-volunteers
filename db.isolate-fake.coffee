module.exports = ->
  fake =
    connect: ->
      save: fake.save
      get: fake.get
    save: ->
      fake.save.called = yes
    get: (id, fn)->
      fn undefined, {}
