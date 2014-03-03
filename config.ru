require 'bundler/setup'
require 'brandaid/app'
require 'brandaid/ui'

map '/css' do
  run BrandAid::App
end

run BrandAid::UI::App
