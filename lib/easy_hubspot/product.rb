# frozen_string_literal: true

module EasyHubspot
  # class EasyHubspot::Product
  class Product < EasyHubspot::Base
    class << self
      PRODUCT_ENDPOINT = 'crm/v3/objects/products'

      def get_product(product_id, access_token = nil)
        Client.do_get(product_id_endpoint(product_id), headers(access_token))
      end

      def get_products(access_token = nil)
        Client.do_get(PRODUCT_ENDPOINT, headers(access_token))
      end

      def create_product(body, access_token = nil)
        Client.do_post(PRODUCT_ENDPOINT, body, headers(access_token))
      end

      def update_product(product_id, body, access_token = nil)
        Client.do_patch(product_id_endpoint(product_id), body, headers(access_token))
      end

      def delete_product(product_id, access_token = nil)
        Client.do_delete(product_id_endpoint(product_id), headers(access_token))
      end

      private

      def product_id_endpoint(product_id)
        "#{PRODUCT_ENDPOINT}/#{product_id}"
      end
    end
  end
end
