require './lib/brandaid/app'
class TestCss < MiniTest::Test
  def test_to_css
    assert_equal BrandAid::Css.css({
      fonts: [{
                head: ["h1"],
                body: {
                  'font-family' => ["Helvetica", "Arial", "Droid Sans", "sans-serif"],
                },
              }]
    }), <<"foo"
h1 {
\tfont-family: "Helvetica", "Arial", "Droid Sans", "sans-serif";
}
foo
  end
end
