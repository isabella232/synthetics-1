require 'awesome_print'
module Synthetics
  class API
    # This class makes requests to the collection methods in the monitors
    # section of the Synthetics API.
    class Monitors < Base
      def list
        request(path: '/monitors', method: 'GET')
      end

      def list_paginated(limit, next_page_link = nil)
        results = nil

        if next_page_link.nil?
          results = request(path: "/monitors?offset=0&limit=#{limit}", method: 'GET')
        else
          results = request(path: next_page_link, method: 'GET')
        end

        results[:links] = links_header_to_hash(results[:headers][:Link])
        results
      end

      def create(options)
        request(path: '/monitors', method: 'POST', body: options)
      end

      private

      def links_header_to_hash(link_header)
        return nil if link_header.nil?
        links_hash = Hash.new

        links_raw = link_header.split(', ')

        # We'll have links for first, last, previous and next. Each separated by a comma.
        # From the URL we only want /monitors on.
        links_raw.each do |link|
          # Extract the URL and its label:
          matches = /<https:.*(\/monitors.*)>; rel=\"(\w+)\"/.match(link)
          captures = matches.captures unless matches.nil?
          links_hash[captures[1]] = captures[0] unless captures.nil? || captures[0].nil? || captures[1].nil?
        end
        links_hash
      end
    end
  end
end
