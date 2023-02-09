# frozen_string_literal: true

module EasyHubspot
  # EasyHubspot::Client
  class Client
    class << self
      def do_get(path = nil, headers = {}, format_plain: true)
        if format_plain
          response = HTTParty.get("#{EasyHubspot.configuration.base_url}#{path}", headers: headers,
                                                                                  format: :plain)
          parse_response(response)
        else
          HTTParty.get("#{EasyHubspot.configuration.base_url}#{path}", headers: headers)
        end
      end

      def do_post(path = nil, body = {}, headers = {}, format_plain: true)
        if format_plain
          response = HTTParty.post("#{EasyHubspot.configuration.base_url}#{path}", body: body, headers: headers,
                                                                                   format: :plain)
          parse_response(response)
        else
          HTTParty.post("#{EasyHubspot.configuration.base_url}#{path}", body: body, headers: headers)
        end
      end

      def do_patch(path = nil, body = {}, headers = {}, format_plain: true)
        if format_plain
          response = HTTParty.patch("#{EasyHubspot.configuration.base_url}#{path}", body: body, headers: headers,
                                                                                    format: :plain)
          parse_response(response)
        else
          HTTParty.patch("#{EasyHubspot.configuration.base_url}#{path}", body: body, headers: headers)
        end
      end

      def do_delete(path = nil, headers = {}, format_plain: true)
        if format_plain
          response = HTTParty.delete("#{EasyHubspot.configuration.base_url}#{path}", headers: headers,
                                                                                     format: :plain)
          parse_response(response)
        else
          HTTParty.delete("#{EasyHubspot.configuration.base_url}#{path}", headers: headers)
        end
      end

      private

      def parse_response(res)
        return if res.body.nil?

        JSON.parse res, symbolize_names: true
      end
    end
  end
end
