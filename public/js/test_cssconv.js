(function(){var requirejs;requirejs=require("requirejs");requirejs.config({nodeRequire:require});requirejs(["cssconv"],function(css){return console.log(css.rules([[["h1"],[["font-family",["Arial","sans-serif"]]]]]))})}).call(this);