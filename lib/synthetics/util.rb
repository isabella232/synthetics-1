module Synthetics
  # This module holds general purpose utilities for the gem.
  module Util
    module_function

    def deep_snakeify_keys(object)
      deep_transform_keys(object) { |key| snakeify(key).to_sym }
    end

    def deep_camelize_keys(object)
      deep_transform_keys(object) { |key| camelize(key.to_s) }
    end

    def deep_transform_keys(object, &block)
      case object
      when Hash
        object.each_with_object({}) do |(key, value), hash|
          hash[yield key] = deep_transform_keys(value, &block)
        end
      when Array
        object.map { |elem| deep_transform_keys(elem, &block) }
      else
        object
      end
    end

    def camelize(str)
      first, *rest = str.split('_')
      rest.each_with_object(first) { |word, memo| memo << word.capitalize }
    end

    def snakeify(str)
      str.gsub(/[A-Z]/) { |letter| "_#{letter.downcase}" }
    end
  end
end
