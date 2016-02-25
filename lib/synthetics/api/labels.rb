module Synthetics
  class API
    # This class makes requests to the collection methods of the labels section
    # of the Synthetics API.
    class Labels < Base
      def list
        request(method: 'GET', path: '/monitors/labels')
      end
    end
  end
end
