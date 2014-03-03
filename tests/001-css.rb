require './lib/brandaid/app'
class TestCss < MiniTest::Test
  def test_to_css
    rules = [[["h1"],
              [
               ['font-family', ["Helvetica", "Arial", "Droid Sans", "sans-serif"]],
              ]
             }]
    assert_equal BrandAid::Css.css(rules), <<"foo"
h1 {
\tfont-family: "Helvetica", "Arial", "Droid Sans", "sans-serif";
}
foo
  end
end
