# frozen_string_literal: true

module EasyHubspot
  # EasyHubspot::Client
  class Client
    class << self
      def do_get(path = nil, headers = {})
        response = HTTParty.get("#{EasyHubspot.configuration.base_url}#{path}", headers: headers,
                                                                                format: :plain)
        parse_response(response)
      end

      def do_post(path = nil, body = {}, headers = {})
        response = HTTParty.post("#{EasyHubspot.configuration.base_url}#{path}", body: body, headers: headers,
                                                                                 format: :plain)
        parse_response(response)
      end

      def do_patch(path = nil, body = {}, headers = {})
        response = HTTParty.patch("#{EasyHubspot.configuration.base_url}#{path}", body: body, headers: headers,
                                                                                  format: :plain)
        parse_response(response)
      end

      def do_delete(path = nil, headers = {})
        response = HTTParty.delete("#{EasyHubspot.configuration.base_url}#{path}", headers: headers,
                                                                                   format: :plain)
        parse_response(response)
      end

      private

      def parse_response(res)
        return if res.body.nil?

        JSON.parse res, symbolize_names: true
      end
    end
  end
end
