$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'synthetics'
require 'pry'
require 'vcr'

Dir['spec/support/**/*.rb'].each do |file|
  load file
end
