require 'slim'
module BrandAid
  module UI
    class App < Sinatra::Base
      helpers BrandAid::ModelHelpers
      get "/" do
        slim :index
      end
      post "/" do
        begin
          brand = {
            name: params[:name],
            scripts: {},
            styles: {}
          }
          BrandAid::Session[:brands].insert(brand)
        ensure
          redirect url(params[:name])
        end
      end
      get '/:brand/?' do |brand|
        get_brand brand
        slim :brand
      end
      get '/:brand/:file.js' do |brand, file|
        get_brand brand
        content_type "application/javascript"
        begin
          @brand["scripts"][file]
        rescue
          pass
        end
      end
      post '/:brand/' do |brand|
        begin
          get_brand brand
          styles = @brand["styles"] ||= {}
          styles[params[:file]] = JSON.parse params[:body]
          # flash "Style #{params[:file]} has been created/updated"
          put_brand brand
        ensure
          redirect url brand
        end
      end
      post '/:brand/js' do |brand|
        begin
          get_brand brand        
          scripts = @brand["scripts"] ||= {}
          scripts[params[:file]] = params[:body]
          put_brand brand
          # flash "Script #{params[:file]} has been created/updated"
        ensure
          redirect url brand
        end
      end
    end
  end
end
