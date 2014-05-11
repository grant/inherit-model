inherit = require 'inherit'

###
A basic model
###
Model = inherit
  set: (name, value) ->
    @attr[name] = value

  get: (name) ->
    @attr[name]

module.exports = Model