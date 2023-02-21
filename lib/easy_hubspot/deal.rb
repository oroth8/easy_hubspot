# frozen_string_literal: true

module EasyHubspot
  # class EasyHubspot::deal
  class Deal < EasyHubspot::Base
    class << self
      DEAL_ENDPOINT = 'crm/v3/objects/deals'

      def get_deal(deal_id)
        Client.do_get(deal_id_endpoint(deal_id), headers)
      end

      def get_deals
        Client.do_get(DEAL_ENDPOINT, headers)
      end

      def create_deal(body)
        Client.do_post(DEAL_ENDPOINT, body, headers)
      end

      def update_deal(deal_id, body)
        Client.do_patch(deal_id_endpoint(deal_id), body, headers)
      end

      def delete_deal(deal_id)
        Client.do_delete(deal_id_endpoint(deal_id), headers)
      end

    private

      def deal_id_endpoint(deal_id)
        "#{DEAL_ENDPOINT}/#{deal_id}"
      end
  end
  end
end
