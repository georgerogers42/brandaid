require 'sinatra/base'
require 'brandaid/model'
require 'warden'

module BrandAid
  module Auth
    class Login < Sinatra::Base
      helpers BrandAid::ModelHelpers
      # get '/signup' do
      #  slim :signup
      # end
      # post '/signup' do
        # user = params['user']
        # email = params['email'].downcase
        # pass1 = params['pass1']
        # pass2 = params['pass2']
        # salt = DateTime.now.iso8601
        # if pass1 == pass2
          # BrandAid.Session[:users].insert(user: user.downcase, pass: Auth.digest(user, pass1, salt), salt: salt, email: email)
          # create_brand user
          # redirect url '/login'
        # else
          # redirect url '/signup'
        # end
      # end
      get '/login' do
        slim :login
      end
      post '/logout' do
        env['warden'].logout
        redirect '/'
      end
      post '/login' do
        env['warden'].authenticate
        redirect "/#{params['user']}"
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
    user = BrandAid.session[:users].find(_id: info)
  end
  Warden::Strategies.add :password do
    def valid?
      not(params['user'].nil? || params['pass'].nil?)
    end
    def authenticate!
      user = params['user']
      pass = params['pass']
      session = BrandAid.session
      u = session[:users].find(user: user.downcase).first
      if !u.nil? && Auth.digest(user, pass, u["salt"]) == u["pass"]
        success!(u)
      else
        fail!("WHO ART THOU!")
      end
    end
  end
end
