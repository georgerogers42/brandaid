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
    assert_equal resp["rules"], [[[".masthead"], [["font-family", ["serif"]]]]]
  end
end
