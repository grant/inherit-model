inherit = require 'inherit'

###
A basic model
###
Model = inherit

  # All of the attributes in this class
  _attr: {}

  # Initializes class fields
  fields: (fields) ->
    for name, value in fields
      @_attr[name] = fields

  # Setter
  # Ex: model.set 'name', 'grant'
  # Ex: model.set 'name': 'grant', 'twitter': 'granttimmerman'
  set: ->
    if arguments.length == 2
      name = arguments[0]
      value = arguments[1]
      if @_attr[name]?
        @_attr[name] = value
      else
        throw Error "Attribute: '#{name}' not defined."
    else # Assume 1 argument
      for name, value in arguments
        @set name, value

  # Getter
  # Ex: model.get 'name # 'grant'
  get: (name) ->
    if @_attr[name]?
      @_attr[name]
    else
      throw Error "Attribute: '#{name}' not defined."

module.exports = Model