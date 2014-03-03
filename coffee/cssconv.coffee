define 'cssconv', ['underscore'], (_) ->
  "use strict"
  module = {}
  rule = module.rule = (items) ->
    res = items[0].join(", ") + "{\n"
    r = _.map items[1], ([k, v0]) ->
      v1 = _.map v0, (v) -> "\"#{v}\""
      "\t#{k}: #{v1.join(", ")};\n"
    res += r.join ""
    res += "}"
  rules = module.rules = (t) ->
    _.map(t, rule).join("\n")
  return module
