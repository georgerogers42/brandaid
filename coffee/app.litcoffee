    "use strict"
    require ["jquery", "js/bower_components/jsoneditor/jsoneditor-min", "js/cssconv.js.min", "js/buckUnder.js.min", "js/eval.js.min"], ($, json, cssconv, $_, mkEval) ->
      $ () ->
        style = $("#styleName").val()
        x = $("<div>")
        update = () ->
          $("#jsonBody").val(e.getText())
          $("pre#stylesheet").text(cssconv.rules(e.get()))
        e = new json.JSONEditor x[0],
          modes: ['tree', 'code']
          change: update
        cson = JSON.parse($("input#styles").val())?[$("input#styleName").val()]
        bh = (style) ->
          e.set(cson)
          update()
        bh(style)
        $("pre#stylesheet").text(cssconv.rules(cson))
        $("p#jsonEditor").append(x)
        $("form#parseCson").on "submit", (evt) ->
          evt.preventDefault()
          data =
            body: $(this).find('textarea[name="body"]').val()
          req = $.ajax($("#appRoot").val() + "/to/cson", data: data, type: "post", dataType: 'json')
          req.done (data) ->
            e.set(data)
            update()
          req.fail (w, msg) ->
            alert(msg)
        evaluator = mkEval({$_: $_})
        $("form#loadScript").on "submit", (evt) ->
          evt.preventDefault()
          macroName = $(this).find("input.file").val()
          req = $.ajax "/#{$("#brandName").val()}/#{macroName}.coffee"
          req.done (data) ->
            $("#macro").val(data)
          req.fail (foo, err) ->
            alert(err)
        $("button#run").on "click", (evt) ->
          script = $("#macro").val()
          f = evaluator(script)
          f e.get(), (data) ->
            e.set(data)
            update()
