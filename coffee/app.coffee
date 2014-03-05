require ["bower_components/jsoneditor/jsoneditor-min", "cssconv"], (json, css) ->
  $ () ->
    x = $("<div>")
    update = () ->
      $("pre#stylesheet").text(css.rules(e.get()))
    e = new json.JSONEditor x[0],
      modes: ['tree', 'code']
      change: update
    json = JSON.parse($("input#styles").val()).default
    e.set(json)
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
    $("form#styleEditor").on "submit", (evt) ->
      evt.preventDefault()
      data =
        body: e.getText()
        file: $("input#styleName").val()
      req = $.ajax "",
        type: "post"
        data: data
      req.done (data) ->
        alert data
      req.fail (self, data) ->
        e.set(json)
        update()
        alert data
