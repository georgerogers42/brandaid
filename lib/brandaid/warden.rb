require 'sinatra/base'
require 'warden'

module BrandAid
  module Auth
    class Login < Sinatra::Base
      get '/login' do
        slim :login
      end
      post '/logout' do
        env['warden'].logout
        redirect url '/login'
      end
      post '/login' do
        env['warden'].authenticate
        redirect url '/'
      end
    end
    extend self
    def salt user, pass, salter
      (salter + user * pass.length + pass * user.length) * salter.length
    end
    def digest user, pass, salter
      Digest::SHA512.base64digest(salt(user, pass, salter))
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
      u = session[:users].find(user: user).first
      if !u.nil? && Auth.digest(user, pass, u["salt"]) == u["pass"]
        success!(u)
      else
        fail!("WHO ART THOU!")
      end
    end
  end
end
