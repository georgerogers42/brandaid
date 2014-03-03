define 'cssconv', ['bower_components/underscore/underscore'], (_) ->
  "use strict"
  module = {}
  rule = module.rule = (items) ->
    res = items[0].join(", ") + " {\n"
    r = _.map items[1], ([k, v]) ->
      if typeof v == "string"
        "\t#{k}: #{v}"
      else
        "\t#{k}: #{v.join(", ")};\n"
    res += r.join ""
    res += "}"
  rules = module.rules = (t) ->
    _.map(t, rule).join("\n")
  return module
