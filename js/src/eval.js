define([], function() {
  return function(window) {
    with(window) {
      return function(quine) {
        "use strict";
        return eval(CoffeeScript.compile(quine, {bare: true}));
      };
    }
  };
});
