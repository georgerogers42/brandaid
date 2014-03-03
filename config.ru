require 'bundler/setup'
require './lib/brandaid/app'
require './lib/brandaid/ui'

map '/css' do
  run BrandAid::App
end

run BrandAid::UI::App
