require 'rack/test'
require 'json'
require 'brandaid/app'
class BrandAid::TestApp < MiniTest::Test
  include Rack::Test::Methods
  def app
    BrandAid::App.new
  end
  def test_audiotech
    get "/audiotech"
    resp = JSON.parse(last_response.body)
    rules = resp["styles"]["default"]
    assert_equal rules, [[[".masthead"], [["font-family", ["serif"]]]]]
    get "/audiotech.css"
    css = last_response.body
    assert_equal BrandAid::Css.rules(rules), css
  end
end
