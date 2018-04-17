module Synthetics
  # This class wraps Excon to make requests to the Synthetics API.
  class Client
    include Util

    def initialize(api_key)
      @api_key = api_key.freeze
    end

    def request(options)
      wrap_errors do
        normailze_request_options!(options)
        response = excon.request(options)
               
        return nil if response.body.empty?
        response_body = deep_snakeify_keys(JSON.parse(response.body))
        response_body[:headers] = response.headers
        response_body
      end
    end

    private

    def wrap_errors
      yield
    rescue JSON::JSONError => ex
      raise ParseError, ex
    rescue Excon::Errors::ClientError => ex
      raise ClientError, ex
    rescue Excon::Errors::ServerError => ex
      raise ServerError, ex
    end

    def normailze_request_options!(opts)
      opts[:path] = API_PATH_PREFIX + opts[:path]
      opts[:headers] ||= {}
      opts[:headers].merge!(
        'Content-Type' => 'application/json',
        'X-API-Key' => @api_key
      )
      if opts.key?(:body) && !opts[:body].is_a?(String)
        opts[:body] = deep_camelize_keys(opts[:body]).to_json
      end
      opts[:expects] = 200..204
    end

    def excon
      @excon ||= Excon.new(API_HOST)
    end
  end
end
