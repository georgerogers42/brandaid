// Generated by CoffeeScript 1.7.1
(function() {
  var requirejs;

  requirejs = require('requirejs');

  requirejs.config({
    nodeRequire: require
  });

  requirejs(['cssconv'], function(css) {
    var x;
    x = css.rules([[["h1"], [["font-family", ['"Arial"', "sans-serif"]]]]]);
    if (x === "h1 {\n\tfont-family: \"Arial\", sans-serif;\n}") {
      return console.log(x);
    }
  });

}).call(this);

//# sourceMappingURL=test_cssconv.map
