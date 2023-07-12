# frozen_string_literal: true

module NotSoEasyHubspot
  # NotSoEasyHubspot::Client
  class Client
    class << self
      def do_get(path = nil, headers = {})
        response = HTTParty.get("#{NotSoEasyHubspot.configuration.base_url}#{path}", headers: headers,
                                                                                format: :plain)
        parse_response(response)
      end

      def do_post(path = nil, body = {}, headers = {})
        response = HTTParty.post("#{NotSoEasyHubspot.configuration.base_url}#{path}", body: body, headers: headers,
                                                                                 format: :plain)
        parse_response(response)
      end

      def do_patch(path = nil, body = {}, headers = {})
        response = HTTParty.patch("#{NotSoEasyHubspot.configuration.base_url}#{path}", body: body, headers: headers,
                                                                                  format: :plain)
        parse_response(response)
      end

      def do_delete(path = nil, headers = {})
        response = HTTParty.delete("#{NotSoEasyHubspot.configuration.base_url}#{path}", headers: headers,
                                                                                   format: :plain)
        parse_response(response).nil? ? { status: 'success' } : parse_response(response)
      end

      private

      def parse_response(res)
        return { status: 'error', message: '404 Not Found' } if res.code == 404

        return if res.body.nil? || res.body.empty?

        parsed_res = JSON.parse res, symbolize_names: true
        raise NotSoEasyHubspot::HubspotApiError, parsed_res[:message] if parsed_res[:status] == 'error'

        parsed_res
      end
    end
  end
end
