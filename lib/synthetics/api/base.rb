module Synthetics
  class API
    # This class defines common methods for all APIs.
    class Base
      extend Forwardable

      def_delegators :@client, :request

      def initialize(client)
        @client = client
      end
    end
  end
end
