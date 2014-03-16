    "use strict"
    define ["js/buckUnder.js.min"], (_) ->
      module = {}
      rule = module.rule = (items) ->
        return [] if items.kind isnt "font"
        rs = _.map items.selectors, (rx) ->
          return rx.join " " if _.isArray rx
          return rx
        res = rs.join(", ") + " {\n"
        x = items.rules
        x = _.pairs x unless _.isArray x
        r = _.map x, ([k, v]) ->
          if typeof v == "string"
            "\t#{k}: #{v};\n"
          else if _.isArray v
            "\t#{k}: #{v.join(", ")};\n"
          else
            throw new Error("Not valid cson")
        res += r.join ""
        res += "}"
        return [res]
      rules = module.rules = (t) ->
        try
          _.catmap(t, rule).join("\n")
        catch e
          e
      return module
