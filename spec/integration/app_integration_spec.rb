$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rack/test'
require 'hawt/app'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end

module Hawt
  describe 'hawt app' do
    include Rack::Test::Methods

    def app
      @app ||= Hawt::App
    end

    def session_data(opts = {})
      {'rack.session' => {
        'current_user' => stub(:id => '12345', :nick => 'testuser', :token => 'foo'),
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

    context '/login' do
      it 'redirects to /auth/github?origin=/' do
        get '/login'
        last_response.status.should == 302
        last_response.location.should == 'http://example.org/auth/github?origin=/'
      end
    end

    context 'when logged in' do
      use_vcr_cassette 'github_watched_repos', :match_requests_on => [:host, :path]
      let(:response) { get '/', {}, session_data }
      it { response.should be_ok }
      it 'has logout link' do
        response.body.should match(/Logout/)
      end
    end

    context 'when logging out' do
      let(:response) { get '/logout' }

      it 'returns 302' do
        response.status.should == 302
      end

      it 'redirects to /' do
        response.location.should == 'http://example.org/'
      end
    end
  end
end
