require 'brandaid/app'
class BrandAid::TestCss < MiniTest::Test
  def test_rules
    rules = [[[".primary"],
              [
               ['font-family', ['"Helvetica"', '"Arial"', '"Droid Sans"', "sans-serif"]],
              ]
             ]
            ]
    assert_equal BrandAid::Css.rules(rules), <<"foo"
.primary {
\tfont-family: "Helvetica", "Arial", "Droid Sans", sans-serif;
}
foo
  end
end
