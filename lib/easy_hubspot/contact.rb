module EasyHubspot
  class Contact < Base

    def get_contact_by_id(id)
      path = "crm/v3/objects/contacts/#{id}"
      res = HTTParty.get("#{BASE_URI}/#{path}", headers:, format: :plain)
      JSON.parse res, symbolize_names: true
      parse_response(res)
    end

    def get_contact_by_email(email)
      path = "crm/v3/objects/contacts/#{email}?idProperty=email"
      res = HTTParty.get("#{BASE_URI}/#{path}", headers:, format: :plain)
      JSON.parse res, symbolize_names: true
      parse_response(res)
    end

    def get_contacts(path: "crm/v3/objects/contacts")
      res = HTTParty.get("#{BASE_URI}/#{path}", headers:, format: :plain)
      JSON.parse res, symbolize_names: true
      parse_response(res)
    end

    def create(path, body)
      HTTParty.post("#{BASE_URI}/#{path}", body, headers:)
    end
  end
end
