require 'sinatra/base'
require 'slim'
require './lib/brandaid/model'
module BrandAid
  class App < Sinatra::Base
    get '/:brand.css' do |brand|
    end
    get '/:brand' do |brand|
    end
  end
end
