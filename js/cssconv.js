// Generated by CoffeeScript 1.7.1
(function() {
  define('cssconv', ['underscore'], function(_) {
    "use strict";
    var module, rule, rules;
    module = {};
    rule = module.rule = function(items) {
      var r, res;
      res = items[0].join(", ") + " {\n";
      r = _.map(items[1], function(_arg) {
        var k, v;
        k = _arg[0], v = _arg[1];
        return "\t" + k + ": " + (v.join(", ")) + ";\n";
      });
      res += r.join("");
      return res += "}";
    };
    rules = module.rules = function(t) {
      return _.map(t, rule).join("\n");
    };
    return module;
  });

}).call(this);

//# sourceMappingURL=cssconv.map
