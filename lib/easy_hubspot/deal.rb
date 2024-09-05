# frozen_string_literal: true

module EasyHubspot
  # class EasyHubspot::deal
  class Deal < EasyHubspot::Base
    class << self
      DEAL_ENDPOINT = 'crm/v3/objects/deals'

      def get_deal(deal_id, access_token = nil)
        Client.do_get(deal_id_endpoint(deal_id), headers(access_token))
      end

      def get_deals(access_token = nil)
        Client.do_get(DEAL_ENDPOINT, headers(access_token))
      end

      def create_deal(body, access_token = nil)
        Client.do_post(DEAL_ENDPOINT, body, headers(access_token))
      end

      def update_deal(deal_id, body, access_token = nil)
        Client.do_patch(deal_id_endpoint(deal_id), body, headers(access_token))
      end

      def delete_deal(deal_id, access_token = nil)
        Client.do_delete(deal_id_endpoint(deal_id), headers(access_token))
      end

      private

      def deal_id_endpoint(deal_id)
        "#{DEAL_ENDPOINT}/#{deal_id}"
      end
    end
  end
end
