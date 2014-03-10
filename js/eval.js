mkEval = function(window) {
  with(window) {
    return function(quine) {
      "use strict";
      return eval(quine);
    };
  }
};
