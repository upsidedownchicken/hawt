require 'sinatra'
require 'ostruct'
require 'omniauth-github'

module Hawt
  class User < Struct.new(:id, :nick)
  end

  class App < Sinatra::Base
    use Rack::Session::Cookie

    configure do
      use OmniAuth::Builder do
        provider :github, ENV['github_app_id'], ENV['github_app_secret']
      end

      set :root, File.expand_path('../../..', __FILE__)
      set :method_override, true
    end

    helpers do
      def current_user
        session[:current_user]
      end
    end

    before do
      @nav_links = [
        OpenStruct.new(:active? => true, :path => '/', :title => 'Home')
      ]
    end

    get '/' do
      haml :index
    end

    get '/auth/github/callback' do
      auth = request.env['omniauth.auth']
      session[:current_user] = User.new auth[:uid], auth[:info][:nickname]
      redirect request.env['omniauth.origin'] || '/'
    end

    get '/login' do
      redirect '/auth/github?origin=/'
    end

    get '/logout' do
      session.clear
      redirect '/'
    end
  end
end
