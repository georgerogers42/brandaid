// Generated by CoffeeScript 1.7.1
(function() {
  "use strict";
  define(["underscore"], function(_) {
    var catmap, find, findIndex, module;
    module = Object.create(_);
    catmap = module.catmap = function(x, p) {
      var a, v, _i, _len;
      a = [];
      for (_i = 0, _len = x.length; _i < _len; _i++) {
        v = x[_i];
        a.push.apply(a, p(v));
      }
      return a;
    };
    findIndex = module.findIndex = function(x, p) {
      var e, i, _i, _len;
      for (i = _i = 0, _len = x.length; _i < _len; i = ++_i) {
        e = x[i];
        if (p(e)) {
          return i;
        }
      }
      return void 0;
    };
    find = module.find = function(x, p) {
      var idx;
      idx = indexOf(x, p);
      if (idx != null) {
        return x[idx];
      }
    };
    return module;
  });

}).call(this);
