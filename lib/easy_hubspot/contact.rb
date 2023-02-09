module EasyHubspot
  # class EasyHubspot::Contact
  class Contact < EasyHubspot::Base
    class << self
      CONTACT_ENDPOINT = 'crm/v3/objects/contacts'.freeze

      def get_contact(contact_id)
        path = merge_path(determine_endpoint(contact_id))
        Client.do_get(path, headers)
      end

      def get_contacts
        Client.do_get(contact_path, headers)
      end

      def create_contact(body)
        Client.do_post(contact_path, body, headers)
      end

      def update_contact(contact_id, body)
        path = merge_path(determine_endpoint(contact_id))
        Client.do_patch(path, body, headers)
      end

      def delete_contact(contact_id)
        path = merge_path(determine_endpoint(contact_id))
        Client.do_delete(path, headers)
      end

      def get_associated_contacts(contact_id, object_type, object_id, association_id)
        path = merge_path("#{CONTACT_ENDPOINT}/#{contact_id}/associations/#{object_type}/#{object_id}/#{association_id}")
        Client.do_get(path, headers)
      end

    private

      def contact_path
        merge_path(CONTACT_ENDPOINT)
      end

      def determine_endpoint(value)
        email_endpoint = "#{CONTACT_ENDPOINT}/#{value}?idProperty=email"
        id_endpoint = "#{CONTACT_ENDPOINT}/#{value}"
        email?(value.to_s) ? email_endpoint : id_endpoint
      end
  end
  end
end
