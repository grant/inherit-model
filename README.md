# inherit-model

A simple Backbone-inspired model wrapper for the npm `inherit` package

## Why?

- Universal getter and setter methods `get` and `set`. Don't have 100s of getters and setters.
- Don't accidentally set properties of classes that aren't defined again. Fields are strict.
- Simple `toJSON`.
- Easy default fields.
- Keeps things lightweight.

## Example

```coffee
inherit = require 'inherit'
Model = require 'inherit-model'

User = inherit Model,
  __constructor: (params = {}) ->
    # Set the field names permanently
    @fields
      username: undefined
      friendIds: []

    # Call the super class (DON'T FORGET!!!)
    @__base(params)

user = new User username: 'grant'
user.set 'username', 'gdawg'

console.log user.toJSON() # {username: 'gdawg', friendIds: []}
```

See the [tests](test/tests.coffee) for more exampless.

## Install

```bash
npm install inherit-model --save
```
