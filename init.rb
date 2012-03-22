$LOAD_PATH.unshift(::File.expand_path('lib', ::File.dirname(__FILE__)))

begin
  require '.bundle/environment'
rescue LoadError
  require 'bundler/setup'
end

Bundler.setup :default

require 'hawt/app'
