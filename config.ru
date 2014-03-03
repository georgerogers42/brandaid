require 'bundler/setup'
require './lib/brandaid/app'
require './lib/brandaid/ui'

map '/admin' do
  run BrandAid::UI::App
end
run BrandAid::App
