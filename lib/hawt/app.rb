require 'sinatra'
require 'ostruct'

module Hawt
  class App < Sinatra::Base
    use Rack::Session::Cookie

    configure do
      set :root, File.expand_path('../../..', __FILE__)
      set :method_override, true
    end

    helpers do
      def current_user
        session['current_user']
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

    get '/login' do
      redirect '/auth/github?origin=/'
    end

    get '/logout' do
      session.clear
      redirect '/'
    end
  end
end
