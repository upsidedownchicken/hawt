$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rack/test'
require 'hawt/app'

module Hawt
  describe 'hawt app' do
    include Rack::Test::Methods

    def app
      @app ||= Hawt::App
    end

    it 'GET /' do
      get('/').should be_ok
    end
  end
end
