require 'rack/test'
require 'json'
require 'brandaid/require'
class BrandAid::TestApp < MiniTest::Test
  include Rack::Test::Methods
  def app
    BrandAid::App.new
  end
  def test_audiotech
    get "/audiotech.json"
    resp = JSON.parse(last_response.body)
    rules = resp["styles"]["default"]
    assert_equal rules, []
    get "/audiotech.css"
    css = last_response.body
    assert_equal BrandAid::Css.rules(rules), css
  end
end
