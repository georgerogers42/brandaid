require './lib/brandaid/app'
class TestCss < MiniTest::Test
  def test_to_css
    rules = [[[".primary"],
              [
               ['font-family', ["Helvetica", "Arial", "Droid Sans", "sans-serif"]],
              ]
             }]
    assert_equal BrandAid::Css.css(rules), <<"foo"
.primary {
\tfont-family: "Helvetica", "Arial", "Droid Sans", "sans-serif";
}
foo
  end
end
