require 'cuba/test'
require 'vcr'
require 'webmock'
require './app'

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = 'tests/fixtures/vcr_cassettes'
  config.hook_into :webmock
end

def json_parse(data)
  JSON.parse(data, symbolize_names: true)
end

Dir['./tests/**/*.rb'].each { |rb| require rb } unless ENV['RUN_ALL_TESTS'] == 'false'
