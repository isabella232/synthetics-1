module Synthetics
  class API
    # This class makes requests to the labels section of the Synthetics API.
    class Label < Base
      attr_reader :label

      def initialize(client, label)
        super(client)
        @label = label
      end

      def monitors
        request(method: 'GET', path: "/monitors/labels/#{label}")
      end

      def attach(monitor_uuid)
        request(
          method: 'POST',
          path: "/monitors/#{monitor_uuid}/labels",
          body: { category: label }
        )
      end

      def remove(monitor_uuid)
        request(
          method: 'DELETE',
          path: "/monitors/#{monitor_uuid}/labels/#{label}"
        )
      end
    end
  end
end
