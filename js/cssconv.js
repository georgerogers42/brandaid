// Generated by CoffeeScript 1.7.1
(function() {
  define(['underscore'], function(_) {
    "use strict";
    var module, rule, rules;
    module = {};
    rule = module.rule = function(t) {
      var res;
      res = t[0].join(", ") + "{\n";
      r += _.map(items[1], function(_arg) {
        var k, v0, v1;
        k = _arg[0], v0 = _arg[1];
        v1 = _.map(v0, function(v) {
          return "\"" + v + "\"";
        });
        return "\t" + k + ": " + (v1.join(", ")) + ";\n";
      });
      res += r.join("");
      return res += "}\n";
    };
    return rules = module.rules = function(t) {
      return _.map(t, rule);
    };
  });

}).call(this);

//# sourceMappingURL=cssconv.map
