module Synthetics
  class API
    # This class makes requests to the locations section of the Synthetics API.
    class Locations < Base
      def list
        request(method: 'GET', path: '/locations')
      end
    end
  end
end
