inherit = require 'inherit'

###
A basic model
###
Model = inherit

  # All of the attributes in this class
  _attr: undefined

  # Initializes class fields
  fields: (fields) ->
    @_attr ?= {}
    for name, value of fields
      @_attr[name] = value

  # Default constructor
  __constructor: (params) ->
    @set params if params
    return

  # Setter
  # Ex: model.set 'name', 'grant'
  # Ex: model.set 'name': 'grant', 'twitter': 'granttimmerman'
  # Returns true if one of the values changed
  set: ->
    if arguments.length == 2
      name = arguments[0]
      value = arguments[1]
      if name of @_attr
        if typeof @_attr[name] == 'object'
          changed = JSON.stringify(@_attr[name]) != JSON.stringify(value)
        else
          changed = @_attr[name] != value
        @_attr[name] = value
        changed
      else
        throw Error "Attribute: '#{name}' not defined."
    else # Assume 1 argument
      fields = arguments[0]
      changed = false
      for name, value of fields
        newset = @set name, value
        changed = changed || newset
      changed

  # Getter
  # Ex: model.get 'name # 'grant'
  get: (name) ->
    if name of @_attr
      @_attr[name]
    else
      throw Error "Attribute: '#{name}' not defined."

  # Returns an object of all the class attributes
  toJSON: ->
    @_attr || {}

module.exports = Model