# frozen_string_literal: true

module EasyHubspot
  # class EasyHubspot::Contact
  class Contact < EasyHubspot::Base
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

    # def get_associated_contacts(contact_id, object_type, object_id, association_id)
    #   # TODO: Error handling arguments
    #   path = merge_path("#{CONTACT_ENDPOINT}/#{contact_id}/associations/#{object_type}/#{object_id}/#{association_id}")
    #   Client.do_get(path, headers)
    # end

    private

      def determine_endpoint(value)
        email_endpoint = "#{CONTACT_ENDPOINT}/#{value}?idProperty=email"
        id_endpoint = "#{CONTACT_ENDPOINT}/#{value}"
        email?(value.to_s) ? email_endpoint : id_endpoint
      end
  end
  end
end
