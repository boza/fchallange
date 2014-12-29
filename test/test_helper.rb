ENV['RACK_ENV'] = 'test'

require "#{__dir__}/.././fyber_app"
require 'minitest/autorun'
require 'rack/test'
require 'mocha/mini_test'
require 'active_support/core_ext/time/calculations'
require 'active_support/testing/assertions'
require 'active_support/testing/time_helpers'

VCR.configure do |c|
  c.cassette_library_dir = "#{__dir__}/vcr_cassettes"
  c.hook_into :webmock
  #c.debug_logger = STDERR
end

class Minitest::Test
  include FactoryGirl::Syntax::Methods
  include ActiveSupport::Testing::Assertions
  include ActiveSupport::Testing::TimeHelpers

end

class RackAppTest < ::Minitest::Test
  include Rack::Test::Methods

  def app
    @app ||= FyberApp
  end

end  
