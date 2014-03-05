require 'brandaid/css.tab'
class BrandAid::CssParserTest < Minitest::Test
  def test_parse
    a = BrandAid::CssParser.new.parse <<END
.foo, .bar {
  font-family: "Times New Roman", serif;
  color: red;
}
.baz {
  font-family: 'Arial', sans-serif;
  color: #00ff00;
}
END
    assert_equal a, [
        [[".foo", ".bar"], [['font-family', ['"Times New Roman"', 'serif']], ['color', ['red']]]],
        [[".baz"], [['font-family', ["'Arial'", "sans-serif"]], ['color', ["#00ff00"]]]]
    ]


  end
end
