      "use strict"
      window.$_ = module = Object.create _

      catmap = module.catmap = (x, p) ->
        a = []
        for v in x
          a.push.apply(a, p(v))
        return a

      findIndex = module.findIndex = (x, p) ->
        for e, i in x
          return i if p(e)
        return undefined
      find = module.find = (x, p) ->
        idx = indexOf(x, p)
        return x[idx] if idx?
      return module
