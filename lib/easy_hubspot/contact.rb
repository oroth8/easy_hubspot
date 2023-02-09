module EasyHubspot
  class Contact < Base
    CONTACT_ENDPOINT = 'crm/v3/objects/contacts'.freeze

    # contact_id: hubspot contact_id or hubspot contact email, returns single contact
    def get_contact(contact_id)
      path = determine_endpoint(contact_id)
      res = HTTParty.get(path, headers:, format: :plain)
      JSON.parse res, symbolize_names: true
      parse_response(res)
    end

    # returns all contacts
    def get_contacts
      res = HTTParty.get("#{BASE_URI}/#{CONTACT_ENDPOINT}", headers:, format: :plain)
      JSON.parse res, symbolize_names: true
      parse_response(res)
    end

    # path: (optional) hubspot api v3 path, body: (required) contact property body
    def create(body)
      res = HTTParty.post("#{BASE_URI}/#{CONTACT_ENDPOINT}", body, headers:, format: :plain)
      parse_response(res)
    end

    def update(contact_id, body)
      path = determine_endpoint(contact_id)
      res = HTTParty.patch(path, body, headers:, format: :plain)
      parse_response(res)
    end

    def delete(contact_id)
      path = determine_endpoint(contact_id)
      res = HTTParty.delete(path, headers:, format: :plain)
      parse_response(res)
    end

    def get_associated_contacts(contact_id, object_type, object_id, association_id)
      res = HTTParty.get(
        "#{BASE_URI}/#{CONTACT_ENDPOINT}/#{contact_id}/associations/#{object_type}/#{object_id}/#{association_id}", headers:, format: :plain
      )
      parse_response(res)
    end

    private

    def determine_endpoint(value)
      email_endpoint = "#{CONTACT_ENDPOINT}/#{value}?idProperty=email"
      id_endpoint = "#{CONTACT_ENDPOINT}/#{value}"
      email?(value.to_s) ? email_endpoint : id_endpoint
    end
  end
end
