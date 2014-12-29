require 'bundler'
Bundler.setup
Bundler.require(:default)

require_relative 'lib/fyber_api'

class FyberApp < Sinatra::Base

  set :raise_exceptions, false
  set :show_exceptions, false

  error do
    haml :error, locals: { error: env['sinatra.error'] }
  end

  get '/' do
    haml :index
  end

  post '/offers' do
    fyber_params = params.merge( { 'appid' => 157, 'device_id' => '2b6f0cc904d137be2e1730235f5664094b831186' } )
    offers = FyberApi::Client.new(fyber_params).offers
    haml :offers, locals: { offers: offers }
  end

end