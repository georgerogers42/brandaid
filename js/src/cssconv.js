// Generated by CoffeeScript 1.7.1
(function() {
  "use strict";
  define(["js/buckUnder.js.min"], function(_) {
    var module, rule, rules;
    module = {};
    rule = module.rule = function(items) {
      var r, res, rs, x;
      rs = _.map(items[0], function(rx) {
        if (_.isArray(rx)) {
          return rx.join(" ");
        }
        return rx;
      });
      res = rs.join(", ") + " {\n";
      x = items[1];
      if (!_.isArray(x)) {
        x = _.pairs(x);
      }
      r = _.map(x, function(_arg) {
        var k, v;
        k = _arg[0], v = _arg[1];
        if (typeof v === "string") {
          return "\t" + k + ": " + v + ";\n";
        } else if (_.isArray(v)) {
          return "\t" + k + ": " + (v.join(", ")) + ";\n";
        } else {
          throw new Error("Not valid cson");
        }
      });
      res += r.join("");
      return res += "}";
    };
    rules = module.rules = function(t) {
      var e;
      try {
        return _.map(t, rule).join("\n");
      } catch (_error) {
        e = _error;
        return e;
      }
    };
    return module;
  });

}).call(this);
