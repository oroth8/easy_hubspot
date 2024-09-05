# frozen_string_literal: true

module EasyHubspot
  # class EasyHubspot::LineItem
  class LineItem < EasyHubspot::Base
    class << self
      LINE_ITEM_ENDPOINT = 'crm/v3/objects/line_items'

      def get_line_item(line_item_id, access_token = nil)
        Client.do_get(line_item_id_endpoint(line_item_id), headers(access_token))
      end

      def get_line_items(access_token = nil)
        Client.do_get(LINE_ITEM_ENDPOINT, headers(access_token))
      end

      def create_line_item(body, access_token = nil)
        Client.do_post(LINE_ITEM_ENDPOINT, body, headers(access_token))
      end

      def update_line_item(line_item_id, body, access_token = nil)
        Client.do_patch(line_item_id_endpoint(line_item_id), body, headers(access_token))
      end

      def delete_line_item(line_item_id, access_token = nil)
        Client.do_delete(line_item_id_endpoint(line_item_id), headers(access_token))
      end

      private

      def line_item_id_endpoint(line_item_id)
        "#{LINE_ITEM_ENDPOINT}/#{line_item_id}"
      end
    end
  end
end
