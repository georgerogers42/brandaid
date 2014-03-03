require 'sinatra/base'
require 'slim'
require 'brandaid/model'
module BrandAid
  class App < Sinatra::Base
    get '/:brand.css' do |brand|
      brand = Session[:brands].find(name: brand).first
      content_type "text/css"
      Css.rules brand["rules"]
    end
    get '/:brand' do |brand|
    end
  end
end
