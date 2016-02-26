require 'base64'
require 'excon'
require 'json'

require 'synthetics/version'
require 'synthetics/constants'
require 'synthetics/errors'
require 'synthetics/util'
require 'synthetics/client'
require 'synthetics/api'

# Top level gem namespace.
module Synthetics
  def self.new(api_key = ENV[API_KEY_ENVIRONMENT_VARIABLE])
    if api_key.nil?
      fail NoAPIKeyError,
           "No API key given, please set $#{API_KEY_ENVIRONMENT_VARIABLE}"
    end
    API.new(Client.new(api_key))
  end
end
