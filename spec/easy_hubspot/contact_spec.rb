require 'spec_helper'

RSpec.describe EasyHubspot::Contact do
  before :all do
    EasyHubspot.config do |config|
      config.access_token = 'YOUR-PRIVATE-ACCESS-TOKEN'
    end
  end

  context 'get_contact' do
    context 'when contact is found using contact_id' do
        before do
            contact_id = '701'
            stub_request(:get, "https://api.hubapi.comhttps//api.hubapi.comcrm/v3/objects/contacts/#{contact_id}")
          .with(
            headers: {
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json'
            }
          )
          .to_return(status: 200, body: load_json('contact'), headers: {})
        end

        let(:response) { EasyHubspot::Contact.get_contact('701') }

        it 'returns a contact' do
            expect(response[:id]).to eq "701"
            expect(response[:properties][:email]).to eq "amber_becker@quigley.io"
        end
    end

    context 'when contact is found using email' do
        before do
            contact_email = "amber_becker@quigley.io"
            stub_request(:get, "https://api.hubapi.comhttps//api.hubapi.comcrm/v3/objects/contacts/#{contact_email}?idProperty=email")
          .with(
            headers: {
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json'
            }
          )
          .to_return(status: 200, body: load_json('contact'), headers: {})
        end

        let(:response) { EasyHubspot::Contact.get_contact("amber_becker@quigley.io") }

        it 'returns a contact' do
            expect(response[:id]).to eq "701"
            expect(response[:properties][:email]).to eq "amber_becker@quigley.io"
        end
    end
  end

  context 'get_contacts' do
    context 'when contacts are found' do
      before do
        stub_request(:get, 'https://api.hubapi.comhttps//api.hubapi.comcrm/v3/objects/contacts')
          .with(
            headers: {
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json'
            }
          )
          .to_return(status: 200, body: load_json('contacts'), headers: {})
      end
      let(:response) { EasyHubspot::Contact.get_contacts }

      it 'returns a list of contacts' do
        results = response[:results]
        expect(results.count).to eq 10
      end
    end
  end
end
