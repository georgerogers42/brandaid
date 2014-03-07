define [], () ->
  "use strict"
  module = Object.create _
  catmap = module.catmap = (x, p) ->
    a = []
    for v in x
      a.push.apply(a, p(v))
    return a
  findIndex = module.indexOf = (x, p) ->
    for pair, i in x
      return i if p(pair)
    return undefined
  find = module.find = (x, p) ->
    idx = indexOf(x, p)
    return x[idx] if idx?
  return module
