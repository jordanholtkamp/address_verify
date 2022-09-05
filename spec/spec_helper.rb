require 'rspec'
require 'dotenv'
require 'webmock/rspec'
require 'vcr'
require 'dotenv/load'


VCR.configure do |config|
    config.cassette_library_dir = "fixtures/vcr_cassettes"
    config.hook_into :webmock
    config.filter_sensitive_data("<ADDRESS_API_KEY>") { ENV['ADDRESS_API_KEY'] }
    config.configure_rspec_metadata!
end