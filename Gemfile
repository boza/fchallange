source 'https://rubygems.org'
ruby '2.1.5'

gem 'sinatra'
gem 'thin'
gem 'haml'
gem 'httparty'


group :development, :test  do
  gem 'factory_girl'
  gem "rack-test", require: "rack/test"
  gem 'minitest', '~> 5.4.2'
  gem 'mocha'
  gem 'guard-minitest'
  gem 'rubycritic', require: false
end

group :test do
  gem 'vcr'
  gem 'webmock'
  gem 'simplecov', require: false
end