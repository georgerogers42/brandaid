"use strict"
$ () ->
  json = jsoneditor
  css = cssconv
  style = $("#styleName").val()
  x = $("<div>")
  update = () ->
    $("#jsonBody").val(e.getText())
    $("pre#stylesheet").text(css.rules(e.get()))
  e = new json.JSONEditor x[0],
    modes: ['tree', 'code']
    change: update
  json = JSON.parse($("input#styles").val())[$("input#styleName").val()]
  bh = (style) ->
    e.set(json)
    update()
  bh(style)
  $("pre#stylesheet").text(css.rules(json))
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
  env = Object.create(window)
  env.$_ = $_
  evaluator = mkEval(env)
  $("form#loadScript").on "submit", (evt) ->
    evt.preventDefault()
    macroName = $(this).find("input.file").val()
    req = $.ajax "/#{$("#brandName").val()}/#{macroName}.js"
    req.done (data) ->
      $("#macro").val(data)
    req.fail (foo, err) ->
      alert(err)
  $("button#run").on "click", (evt) ->
    script = $("#macro").val()
    f = evaluator(script)
    e.set(f(e.get()))
    update()
