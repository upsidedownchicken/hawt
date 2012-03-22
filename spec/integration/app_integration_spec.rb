$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rack/test'
require 'hawt/app'

module Hawt
  describe 'hawt app' do
    include Rack::Test::Methods

    def app
      @app ||= Hawt::App
    end

    def session_data(opts = {})
      {'rack.session' => {
        'current_user' => stub(:id => '12345', :display_name => 'Test User'),
      }.merge(opts)}
    end

    context 'GET /' do
      let(:response) { get '/' }
      it { response.should be_ok }
      it "has login link" do
        response.body.should match(/Login/)
      end
      it 'recommends login' do
        response.body.should match(/Login with GitHub to see your watched repositories/)
      end
    end

    context 'when logged in' do
      let(:response) { get '/', {}, session_data }
      it { response.should be_ok }
      it 'has logout link' do
        response.body.should match(/Logout/)
      end
    end
  end
end
