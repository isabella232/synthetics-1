require 'synthetics/api/base'
require 'synthetics/api/label'
require 'synthetics/api/labels'
require 'synthetics/api/locations'
require 'synthetics/api/monitor'
require 'synthetics/api/monitors'

module Synthetics
  # This class holds the sub APIs used to communicate with synthetics.
  class API
    attr_reader :client

    def initialize(client)
      @client = client
    end
  end
end
