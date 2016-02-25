require 'synthetics/api/base'

module Synthetics
  # This class holds the sub APIs used to communicate with synthetics.
  class API
    attr_reader :client

    def initialize(client)
      @client = client
    end
  end
end
