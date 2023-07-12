# frozen_string_literal: true

module NotSoEasyHubspot
  # class NotSoEasyHubspot::Contact
  class Contact < NotSoEasyHubspot::Base
    class << self
      CONTACT_ENDPOINT = 'crm/v3/objects/contacts'

      def get_contact(contact_id)
        Client.do_get(determine_endpoint(contact_id), headers)
      end

      def get_contacts
        Client.do_get(CONTACT_ENDPOINT, headers)
      end

      def create_contact(body)
        Client.do_post(CONTACT_ENDPOINT, body, headers)
      end

      def update_contact(contact_id, body)
        Client.do_patch(determine_endpoint(contact_id), body, headers)
      end

      def delete_contact(contact_id)
        Client.do_delete(determine_endpoint(contact_id), headers)
      end

      def update_or_create_contact(email, body)
        res = get_contact(email)
        if res && res[:id]
          update_contact(email, body)
        else
          create_contact(body)
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
