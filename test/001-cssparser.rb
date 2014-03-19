require 'brandaid/css.tab'
class BrandAid::CssParserTest < Minitest::Test
  def test_parse
    a = BrandAid::CssParser.new.parse <<END
.foo, div.bar #baz {
  font-family: "Times New Roman", serif;
  color: red;
}
.quux {
  color: green;
}
END
    assert_equal a, [
        {"kind" => "font", "selectors" => [".foo", "div.bar #baz"], "rules" => [['font-family', ['"Times New Roman"', 'serif']], ['color', ['red']]]}, {"kind" => "font", "selectors" => [".quux"], "rules" => [["color", ["green"]]]}
    ]
  end
end
