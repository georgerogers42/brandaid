define [], () ->
  "use strict"
  module = {}
  rule = module.rule = (items) ->
    res = items[0].join(", ") + " {\n"
    x = _.pairs items[1]
    r = _.map x, ([k, v]) ->
      if typeof v == "string"
        "\t#{k}: #{v};\n"
      else if _.isArray v
        "\t#{k}: #{v.join(", ")};\n"
      else
        throw new Error("Not valid cson")
    res += r.join ""
    res += "}"
  rules = module.rules = (t) ->
    try
      _.map(t, rule).join("\n")
    catch e
      e
  return module
