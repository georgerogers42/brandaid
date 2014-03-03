requirejs = require 'requirejs'

requirejs.config nodeRequire: require

requirejs ['cssconv'], (css) ->
  console.log(css.rules([[["h1"], [["font-family", ["Arial", "sans-serif"]]]]]))
