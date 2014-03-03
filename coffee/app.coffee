require ["bower_components/jsoneditor/jsoneditor-min", "cssconv"], (json, css) ->
  $ () ->
    x = $("<div>")
    e = new json.JSONEditor x[0],
      modes: ['tree', 'code']
    e.set(JSON.parse($("input#styles").val()).default)
    $("p#jsonEditor").append(x)
    $("form#styleEditor").on "submit", (evt) ->
      evt.preventDefault()
      data =
        body: e.getText()
        file: $("input#styleName").val()
      req = $.ajax "",
        type: "post"
        data: data
      req.done () ->
        alert "Saved"
