module Synthetics
  class API
    # This class defines common methods for all APIs.
    class Base
      extend Forwardable

      attr_reader :client
      def_delegators :@client, :request

      def initialize(client)
        @client = client
      end
    end
  end
end
