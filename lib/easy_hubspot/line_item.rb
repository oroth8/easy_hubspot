# frozen_string_literal: true

module EasyHubspot
  # class EasyHubspot::LineItem
  class LineItem < EasyHubspot::Base
    class << self
      LINE_ITEM_ENDPOINT = 'crm/v3/objects/line_items'

      def get_line_item(line_item_id)
        Client.do_get(line_item_id_endpoint(line_item_id), headers)
      end

      def get_line_items
        Client.do_get(LINE_ITEM_ENDPOINT, headers)
      end

      def create_line_item(body)
        Client.do_post(LINE_ITEM_ENDPOINT, body, headers)
      end

      def update_line_item(line_item_id, body)
        Client.do_patch(line_item_id_endpoint(line_item_id), body, headers)
      end

      def delete_line_item(line_item_id)
        Client.do_delete(line_item_id_endpoint(line_item_id), headers)
      end

      private

      def line_item_id_endpoint(line_item_id)
        "#{LINE_ITEM_ENDPOINT}/#{line_item_id}"
      end
    end
  end
end
