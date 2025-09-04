# frozen_string_literal: true

module EasyHubspot
  # class EasyHubspot::Contact
  class Company < EasyHubspot::Base
    class << self
      COMPANY_ENDPOINT = 'crm/v3/objects/companies'

      def get_company(company_id, access_token = nil)
        Client.do_get("#{COMPANY_ENDPOINT}/#{company_id}", headers(access_token))
      end

      def find_all_by_name(name, access_token = nil)
        body = {
          "filterGroups": [
            {
              "filters": [
                {
                  "propertyName": "name",
                  "operator": "EQ",
                  "value": name
                }
              ]
            }
          ]
        }.to_json
        Client.do_post("#{COMPANY_ENDPOINT}/search", body, headers(access_token))
      end

      def get_companies(access_token = nil)
        Client.do_get(COMPANY_ENDPOINT, headers(access_token))
      end

      def create_company(body, access_token = nil)
        Client.do_post(COMPANY_ENDPOINT, body, headers(access_token))
      end

      def update_company(company_id, body, access_token = nil)
        Client.do_patch("#{COMPANY_ENDPOINT}/#{company_id}", body, headers(access_token))
      end

      def delete_company(company_id, access_token = nil)
        Client.do_delete("#{COMPANY_ENDPOINT}/#{company_id}", headers(access_token))
      end
    end
  end
end
