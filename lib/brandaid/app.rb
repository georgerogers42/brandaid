require 'sinatra/base'
require 'json'
require 'brandaid/model'
module BrandAid
  class App < Sinatra::Base
    get '/:brand.css' do |brand|
      get_brand brand
      content_type "text/css"
      Css.rules @brand["rules"]
    end
    get '/:brand' do |brand|
      get_brand brand
      JSON.dump @brand
    end
  private
    def get_brand brand
      @brand = Session[:brands].find(name: brand).first
      @brand.delete "_id"
      return @brand
    end
  end
end
