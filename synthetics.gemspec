# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'synthetics/version'

Gem::Specification.new do |spec|
  spec.name          = 'synthetics'
  spec.version       = Synthetics::VERSION
  spec.authors       = ['Tom Hulihan']
  spec.email         = ['hulihan.tom159@gmail.com']

  spec.summary       = 'Ruby client for the New Relic Synthetics'
  spec.description   = <<-EOS
synthetics interfaces with New Relic Synthetics' HTTP API:
https://docs.newrelic.com/docs/apis/synthetics-rest-api/. The gem can be used to
read, create, update, and destroy monitors.
EOS
  spec.homepage      = 'https://github.com/swipely/synthetics'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.start_with?('spec')
  end
  spec.require_paths = %w(lib)

  spec.add_dependency 'excon'
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 1.22'
end
