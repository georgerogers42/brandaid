require 'sinatra/base'
require 'json'
require 'brandaid/model'
module BrandAid
  class App < Sinatra::Base
    helpers ModelHelpers
    get '/:brand/:style.css' do |brand, style|
      get_brand brand
      content_type "text/css"
      Css.rules @brand["styles"][style]
    end
    get '/:brand.css' do |brand|
      get_brand brand
      content_type "text/css"
      Css.rules @brand["styles"]["default"]
    end
    get '/:brand' do |brand|
      get_brand brand
      @brand.delete "_id"
      content_type "application/json"
      JSON.dump @brand
    end
  end
end
