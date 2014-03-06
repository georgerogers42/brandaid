require 'brandaid/css.tab'
require 'addressable/uri'
require 'slim'
module BrandAid
  module UI
    class App < Sinatra::Base
      before do
        env['warden'].authenticate!
      end
      helpers BrandAid::ModelHelpers
      get "/" do
        slim :index
      end
      post '/:brand/to/cson' do |brand|
        JSON.dump BrandAid::CssParser.new.parse(params[:body])
      end
      post "/" do
        begin
          create_brand params[:name]
        ensure
          redirect url(params[:name])
        end
      end
      get '/:brand/?' do |brand|
        @style = params['style'] || 'default'
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
      post '/:brand/?' do |brand|
        get_brand brand
        json = JSON.parse params[:body]
        Css.rules json.clone
        styles = @brand["styles"] ||= {}
        file = params["file"]
        styles[file] = json
        put_brand brand
        u = Addressable::URI.new
        u.query_values = ({style: file})
        redirect url "/#{brand}#{u}"
      end
      post '/:brand/js' do |brand|
        begin
          get_brand brand        
          scripts = @brand["scripts"] ||= {}
          scripts[params[:file]] = params[:body]
          put_brand brand
        ensure
          redirect url brand
        end
      end
    end
  end
end
