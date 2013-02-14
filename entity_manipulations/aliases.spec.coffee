(isolate = require 'isolate').passthru '/node_modules*/', 'cradle'
expect = (require 'chai').expect
aliases = module.isolate './aliases'

DB = aliases.dependencies.find 'db'

describe 'Aliases Manipulations', ->

  it 'should provide an add api', ->
    (expect aliases.add).to.exist

  describe 'add', ->
    beforeEach ->
      DB.get = (id,fn)-> fn undefined, aliases: []
      request =
        body:
          groupId: ''
          alias: ''
          lat: ''
          lng: ''
      response =
        send: ->
          response.send.called = yes
      aliases.add request, response

    it 'should call db.save', ->
      (expect DB.save.called).to.equal yes
