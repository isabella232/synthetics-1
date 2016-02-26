VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr'
  config.configure_rspec_metadata!
  config.hook_into :webmock
end
