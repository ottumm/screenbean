fountain = require 'fountain-js'

module.exports =
  parse: (text, callback) ->
    callback null, fountain.parse(text).script_html
