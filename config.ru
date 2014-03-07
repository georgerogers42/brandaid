require 'bundler/setup'
require './lib/brandaid/import'

use Rack::Session::Cookie, secret:(ENV["SECRET"] || "AGASSDTRArawtjastjksek")
use Warden::Manager do |config|
  config.failure_app = BrandAid::Auth::Login
  config.scope_defaults :default,
    strategies: [:password],
    action: '/login'
end

map '/css' do
  use BrandAid::Auth::Login
  run BrandAid::App
end

use BrandAid::Auth::Login
run BrandAid::UI::App
