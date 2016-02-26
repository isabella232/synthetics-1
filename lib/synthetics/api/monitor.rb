module Synthetics
  class API
    # This class makes requests to the monitors section of the Synthetics API.
    class Monitor < Base
      attr_reader :monitor_uuid

      def initialize(client, monitor_uuid)
        super(client)
        @monitor_uuid = monitor_uuid
      end

      def show
        request(path: "/monitors/#{monitor_uuid}", method: 'GET')
      end

      def update(options)
        request(path: "/monitors/#{monitor_uuid}", method: 'PUT', body: options)
      end

      def update_script(str)
        request(
          path: "/monitors/#{monitor_uuid}/script",
          method: 'PUT',
          body: { script_text: Base64.strict_encode64(str) }
        )
      end

      def destroy
        request(path: "/monitors/#{monitor_uuid}", method: 'DELETE')
      end
    end
  end
end
