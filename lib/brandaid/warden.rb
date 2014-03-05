require 'sinatra/base'
require 'warden'

module BrandAid
  module Auth
    class Login < Sinatra::Base
      get '/login' do
        slim :login
      end
      post '/login' do
        env['warden'].authenticate!
        redirect '/'
      end
    end
    extend self
    def salt user, pass
      user * pass.length + pass * user.length
    end
    def digest user, pass
      Digest::SHA512.base64digest(salt(user, pass))
    end
  end
  Warden::Manager.serialize_into_session do |user|
    JSON.dump [user["user"], Auth.digest(user["user"], user["_id"])]
  end
  Warden::Manager.serialize_from_session do |info|
    name, token = JSON.parse info
    user = Session[:users].find(user: name)
    fail!("WHO ART THOU?") unless token == Auth.digest(user["user"], user["_id"])
  end
  Warden::Strategies.add :password do
    def valid?
      params[:user] && params[:pass]
    end
    def authenticate!
      user = params[:user]
      pass = params[:pass]
      session = BrandAid.Session
      if u = session[:users].find(user: user, pass: BrandAid::Auth.digest(user, pass)).first
        success!(u)
      else
        fail!("WHO ART THOU?")
      end
    end
  end
end
