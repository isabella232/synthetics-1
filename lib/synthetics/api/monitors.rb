module Synthetics
  class API
    # This class makes requests to the collection methods in the monitors
    # section of the Synthetics API.
    class Monitors < Base
      def list
        request(path: '/monitors', method: 'GET')
      end

      def create(options)
        request(path: '/monitors', method: 'POST', body: options)
      end
    end
  end
end
