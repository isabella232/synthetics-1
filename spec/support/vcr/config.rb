VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr'
  config.configure_rspec_metadata!
  config.hook_into :webmock
  config.before_record do |interaction|
    interaction.request.headers['X-Api-Key'] = '<TEST-API-KEY>'
  end
end
