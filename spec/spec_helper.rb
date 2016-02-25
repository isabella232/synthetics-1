$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'synthetics'

Dir['spec/shared_examples/**/*.rb'].each do |file|
  load file
end
