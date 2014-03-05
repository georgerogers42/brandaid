$LOAD_PATH.push("lib")
require 'bundler/setup'
require 'brandaid/app'
require 'brandaid/ui'
require 'brandaid/warden'
require 'rack/session/cookie'

use Rack::Session::Cookie, secret:(ENV["SECRET"] || "AGASSDTRArawtjastjksek")
use Warden::Manager do |config|
  config.failure_app = BrandAid::Auth::Login
  config.scope_defaults :default,
    strategies: [:password],
    action: '/auth/login'
end
map '/auth' do
  run BrandAid::Auth::Login
end
map '/css' do
  run BrandAid::App
end


run BrandAid::UI::App
