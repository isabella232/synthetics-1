module Synthetics
  # Catch-all error class.
  Error = Class.new(StandardError)
  # Raised when parsing JSON fails.
  ParseError = Class.new(Error)
  # Raised when there is a 400 level error returned from the Synthetics API.
  ClientError = Class.new(Error)
  # Raised when there is a 500 level error returned from the Synthetics API.
  ServerError = Class.new(Error)
  # Raised when no API is given to a Synthetics client.
  NoApiKeyError = Class.new(Error)
end
