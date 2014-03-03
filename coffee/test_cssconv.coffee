requirejs = require 'requirejs'

requirejs.config nodeRequire: require

requirejs ['cssconv'], (css) ->
  x = css.rules([[["h1"], [["font-family", ['"Arial"', "sans-serif"]]]]])
  if x == """h1 {\n\tfont-family: "Arial", sans-serif;\n}"""
    console.log x
