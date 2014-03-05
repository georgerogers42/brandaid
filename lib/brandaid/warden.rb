require 'sinatra/base'
require 'warden'

module BrandAid
  module Auth
    class Login < Sinatra::Base
      get '/login' do
        slim :login
      end
      post '/login' do
        env['warden'].authenticate
        redirect '/login'
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
    user['_id']
  end
  Warden::Manager.serialize_from_session do |info|
    user = BrandAid.Session[:users].find(_id: info)
  end
  Warden::Strategies.add :password do
    def valid?
      not(params['user'].nil? || params['pass'].nil?)
    end
    def authenticate!
      user = params['user']
      pass = params['pass']
      session = BrandAid.Session
      u = session[:users].find(user: user, pass: Auth.digest(user, pass)).first
      if u.nil?
        fail!("WHO ART THOU?")
      else
        success!(u)
      end
    end
  end
end
