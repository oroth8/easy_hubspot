# frozen_string_literal: true

module EasyHubspot
  # class EasyHubspot::Contact
  class Contact < EasyHubspot::Base
    class << self
      CONTACT_ENDPOINT = 'crm/v3/objects/contacts'

      def get_contact(contact_id, access_token = nil)
        Client.do_get(determine_endpoint(contact_id), headers(access_token))
      end

      def get_contacts(access_token = nil)
        Client.do_get(CONTACT_ENDPOINT, headers(access_token))
      end

      def create_contact(body, access_token = nil)
        Client.do_post(CONTACT_ENDPOINT, body, headers(access_token))
      end

      def update_contact(contact_id, body, access_token = nil)
        Client.do_patch(determine_endpoint(contact_id), body, headers(access_token))
      end

      def delete_contact(contact_id, access_token = nil)
        Client.do_delete(determine_endpoint(contact_id), headers(access_token))
      end

      def update_or_create_contact(email, body, access_token = nil)
        res = get_contact(email, access_token)
        if res && res[:id]
          update_contact(email, body, access_token)
        else
          create_contact(body, access_token)
        end
      end

      private

      def determine_endpoint(value)
        email_endpoint = "#{CONTACT_ENDPOINT}/#{value}?idProperty=email"
        id_endpoint = "#{CONTACT_ENDPOINT}/#{value}"
        email?(value.to_s) ? email_endpoint : id_endpoint
      end
    end
  end
end
