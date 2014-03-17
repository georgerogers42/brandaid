require 'brandaid'
class BrandAid::TestCss < MiniTest::Test
  def test_rules
    rules = [{"kind" => "font", "selectors" => [".primary"], "rules" => {"font-family" => ['"Helvetica"', '"Arial"', '"Droid Sans"', 'sans-serif']}}]
    assert_equal BrandAid::Css.rules(rules), <<"foo"
.primary {
\tfont-family: "Helvetica", "Arial", "Droid Sans", sans-serif;
}
foo
  end
end
