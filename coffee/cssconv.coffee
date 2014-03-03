define 'cssconv', ['underscore'], (_) ->
  "use strict"
  module = {}
  rule = module.rule = (items) ->
    res = items[0].join(", ") + " {\n"
    r = _.map items[1], ([k, v]) ->
      "\t#{k}: #{v.join(", ")};\n"
    res += r.join ""
    res += "}"
  rules = module.rules = (t) ->
    _.map(t, rule).join("\n")
  return module
