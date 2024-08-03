require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.debug_logger = File.open('tmp/vcr.log', 'w')
  config.configure_rspec_metadata!
  config.ignore_hosts '127.0.0.1', 'localhost'
  config.allow_http_connections_when_no_cassette = true
end
