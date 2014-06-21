inherit = require 'inherit'
Model = require '../'
should = require 'should'

# helpers

objCompare = (expected, actual) ->
  JSON.stringify(actual).should.equal JSON.stringify expected

describe 'model', ->

  # constructor

  describe 'constructor', ->
    it 'should not have any attributes if empty', ->
      User = inherit Model
      user = new User
      objCompare {}, user.toJSON()

    it 'should have default attributes', ->
      User = inherit Model,
        __constructor: ->
          @fields
            username: 'default'

          @__base()

      user = new User
      objCompare {username: 'default'}, user.toJSON()

    it 'should have default undefined attributes', ->
      User = inherit Model,
        __constructor: ->
          @fields
            username: undefined

          @__base()

      user = new User
      objCompare {username: undefined}, user.toJSON()

    it 'should have default attributes that can be overridden', ->
      User = inherit Model,
        __constructor: (fields) ->
          @fields
            username: 'default'

          @__base fields

      user = new User username: 'test'
      objCompare {username: 'test'}, user.toJSON()


  # getters and setters

  describe 'getters and setters', ->
    it 'should reject undefined fields', ->
      Empty = inherit Model

      empty = new Empty
      (->
        empty.set 'badProperty'
      ).should.throw()

      (->
        empty.get 'badProperty'
      ).should.throw()

    it 'should have getters', ->
      User = inherit Model,
        __constructor: (params) ->
          @fields
            username: 'default'
          @__base params

      user = new User username: 'grant'
      user.get('username').should.equal 'grant'

      userDefault = new User
      userDefault.get('username').should.equal 'default'

    it 'should have simple property setters', ->
      User = inherit Model,
        __constructor: (params) ->
          @fields
            username: 'default'
          @__base params

      user = new User username: 'grant'
      user.set 'username', 'dog'
      user.get('username').should.equal 'dog'

      userDefault = new User
      userDefault.set 'username', 'cat'
      userDefault.get('username').should.equal 'cat'

    it 'should have setter object', ->
      User = inherit Model,
        __constructor: (params) ->
          @fields
            username: 'defaultUsername'
            name: 'defaultName'
          @__base params

      user = new User
      user.set
        username: 'grant'
        name: 'g'

      user.get('username').should.equal 'grant'
      user.get('name').should.equal 'g'

    it 'should return false when resetting property same value', ->
      User = inherit Model,
        __constructor: (params) ->
          @fields
            username: 'defaultUsername'
            name: 'defaultName'
          @__base params

      user = new User
      changed = user.set
        username: 'defaultUsername'
      changed.should.be.false

  describe 'toJSON', ->
    it 'should work', ->
      User = inherit Model,
        __constructor: (params) ->
          @fields
            username: 'defaultUsername'
            email: 'defaultName'
          @__base params

      user1 = new User(
        username: 'grant'
        email: 'email@example.com'
      )
      user2 = new User()

      objCompare {username: 'grant', email: 'email@example.com'}, user1.toJSON()
      objCompare {username: 'defaultUsername', email: 'defaultName'}, user2.toJSON()

  describe 'subclassing', ->
    it 'should inherit properties', ->
      Animal = inherit Model,
        __constructor: (params = {}) ->
          @fields
            numLegs: undefined
          @__base params

      Sheep = inherit Animal,
        __constructor: (params = {}) ->
          @fields
            hasHooves: true

          params.numLegs = 4
          @__base params

      sheep = new Sheep
      objCompare {hasHooves: true, numLegs: 4}, sheep.toJSON()