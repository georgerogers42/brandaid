require ["bower_components/jsoneditor/jsoneditor-min", "cssconv"], (json, css) ->
  "use strict"
  $ () ->
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
