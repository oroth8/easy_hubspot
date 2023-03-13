# frozen_string_literal: true

module EasyHubspot
  # class EasyHubspot::Product
  class Product < EasyHubspot::Base
    class << self
      PRODUCT_ENDPOINT = 'crm/v3/objects/products'

      def get_product(product_id)
        Client.do_get(product_id_endpoint(product_id), headers)
      end

      def get_products
        Client.do_get(PRODUCT_ENDPOINT, headers)
      end

      def create_product(body)
        Client.do_post(PRODUCT_ENDPOINT, body, headers)
      end

      def update_product(product_id, body)
        Client.do_patch(product_id_endpoint(product_id), body, headers)
      end

      private

      def product_id_endpoint(product_id)
        "#{PRODUCT_ENDPOINT}/#{product_id}"
      end
    end
  end
end
