# frozen_string_literal: true

require 'spec_helper'

RSpec.describe EasyHubspot::Contact do
  before :all do
    EasyHubspot.config do |config|
      config.access_token = 'YOUR-PRIVATE-ACCESS-TOKEN'
    end
  end

  describe 'get_contact' do
    context 'when contact is found using contact_id' do
      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/contacts/701')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_json('contact'), headers: {})
      end

      let(:response) { described_class.get_contact('701') }

      it 'returns a contact' do
        expect(response[:id]).to eq '701'
        expect(response[:properties][:email]).to eq 'amber_becker@quigley.io'
      end
    end

    context 'when contact is found using email' do
      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/contacts/amber_becker@quigley.io?idProperty=email')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_json('contact'), headers: {})
      end

      let(:response) { described_class.get_contact('amber_becker@quigley.io') }

      it 'returns a contact' do
        expect(response[:id]).to eq '701'
        expect(response[:properties][:email]).to eq 'amber_becker@quigley.io'
      end
    end
  end

  describe 'get_contacts' do
    context 'when contacts are found' do
      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/contacts')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_json('contacts'), headers: {})
      end

      let(:response) { described_class.get_contacts }

      it 'returns a list of contacts' do
        results = response[:results]
        expect(results.count).to eq 10
      end
    end
  end

  describe 'create_contact' do
    before do
      stub_request(:post, 'https://api.hubapi.com/crm/v3/objects/contacts')
        .with(
          body: 'properties%5Bemail%5D=example%40gmail.com&properties%5Bfirstname%5D=John&properties%5Blastname%5D=Smith',
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Ruby'
          }
        )
        .to_return(status: 201, body: load_json('create_contact'), headers: {})
    end

    let(:body) do
      { properties: { email: 'example@gmail.com', firstname: 'John', lastname: 'Smith' } }
    end
    let(:response) { described_class.create_contact(body) }

    it 'returns a contact' do
      expect(response[:id]).to eq '851'
      expect(response[:properties][:email]).to eq 'example@gmail.com'
      expect(response[:properties][:firstname]).to eq 'John'
      expect(response[:properties][:lastname]).to eq 'Smith'
    end
  end

  describe 'update_contact' do
    context 'when contact is found using contact_id' do
      before do
        stub_request(:patch, 'https://api.hubapi.com/crm/v3/objects/contacts/851')
          .with(
            body: 'properties%5Bemail%5D=example%40gmail.com&properties%5Bfirstname%5D=John&properties%5Blastname%5D=Smith',
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_json('update_contact'), headers: {})
      end

      let(:body) do
        { properties: { email: 'example@gmail.com', firstname: 'John', lastname: 'Smith' } }
      end
      let(:response) { described_class.update_contact('851', body) }

      it 'returns a contact' do
        expect(response[:id]).to eq '851'
        expect(response[:properties][:email]).to eq 'example@gmail.com'
        expect(response[:properties][:firstname]).to eq 'Carl'
        expect(response[:properties][:lastname]).to eq 'Smith'
      end
    end

    context 'when contact is found using email' do
      before do
        stub_request(:patch, 'https://api.hubapi.com/crm/v3/objects/contacts/example@gmail.com?idProperty=email')
          .with(
            body: 'properties%5Bemail%5D=example%40gmail.com&properties%5Bfirstname%5D=John&properties%5Blastname%5D=Smith',
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_json('update_contact'), headers: {})
      end

      let(:body) do
        { properties: { email: 'example@gmail.com', firstname: 'John', lastname: 'Smith' } }
      end
      let(:response) { described_class.update_contact('example@gmail.com', body) }

      it 'returns a contact' do
        expect(response[:id]).to eq '851'
        expect(response[:properties][:email]).to eq 'example@gmail.com'
        expect(response[:properties][:firstname]).to eq 'Carl'
        expect(response[:properties][:lastname]).to eq 'Smith'
      end
    end
  end

  describe 'delete_contact' do
    let(:success) { { status: 'success' } }

    context 'when contact is found using contact_id' do
      before do
        stub_request(:delete, 'https://api.hubapi.com/crm/v3/objects/contacts/851')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 204, body: '', headers: {})
      end

      let(:response) { described_class.delete_contact('851') }

      it 'returns no content' do
        expect(response).to eq success
      end
    end

    context 'when contact is found using email' do
      before do
        stub_request(:delete, 'https://api.hubapi.com/crm/v3/objects/contacts/example@gmail.com?idProperty=email')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 204, body: '', headers: {})
      end

      let(:response) { described_class.delete_contact('example@gmail.com') }

      it 'returns no content' do
        expect(response).to eq success
      end
    end
  end

  describe 'errors' do
    context 'when trying to create a duplicate contact' do
      before do
        stub_request(:post, 'https://api.hubapi.com/crm/v3/objects/contacts')
          .with(
            body: 'properties%5Bemail%5D=example%40gmail.com&properties%5Bfirstname%5D=John&properties%5Blastname%5D=Smith',
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 400, body: load_json('duplicate_contact'), headers: {})
      end

      let(:body) do
        { properties: { email: 'example@gmail.com', firstname: 'John', lastname: 'Smith' } }
      end

      it 'raises a HubspotApiError' do
        expect do
          described_class.create_contact(body)
        end.to raise_error(EasyHubspot::HubspotApiError, 'Contact already exists. Existing ID: 801')
      end
    end

    context "when trying to update a contact that doesn't exist" do
      before do
        stub_request(:patch, 'https://api.hubapi.com/crm/v3/objects/contacts/1234')
          .with(
            body: 'properties%5Bemail%5D=example%40gmail.com&properties%5Bfirstname%5D=John&properties%5Blastname%5D=Smith',
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 400, body: load_json('contact_not_found'), headers: {})
      end

      let(:body) do
        { properties: { email: 'example@gmail.com', firstname: 'John', lastname: 'Smith' } }
      end

      it 'raises a HubspotApiError' do
        expect do
          described_class.update_contact('1234', body)
        end.to raise_error(EasyHubspot::HubspotApiError, 'resource not found')
      end
    end

    context 'when hubspot api returns a 404 reponse code' do
      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/contacts/4040')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 404, body: load_json('contact_not_found'), headers: {})
      end

      let(:response) { described_class.get_contact('4040') }

      it 'returns a 404 status error message' do
        expect(response).to eq({ status: 'error', message: '404 Not Found' })
      end
    end
  end

  describe 'update_or_create_contact' do
    context 'when contact is found using contact_id' do
      let!(:email) { 'amber_becker@quigley.io' }
      let(:response) { described_class.update_or_create_contact(email, body) }
      let!(:body) do
        { properties: { email: email, firstname: 'Amber', lastname: 'Quigley', hs_content_membership_status: 'inactive' } }
      end

      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/contacts/amber_becker@quigley.io?idProperty=email')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_json('contact'), headers: {})
        stub_request(:patch, 'https://api.hubapi.com/crm/v3/objects/contacts/amber_becker@quigley.io?idProperty=email')
          .with(
            body: 'properties%5Bemail%5D=amber_becker%40quigley.io&properties%5Bfirstname%5D=Amber&properties%5Blastname%5D=Quigley&properties%5Bhs_content_membership_status%5D=inactive',
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_json('update_or_create_contact'), headers: {})
      end

      it 'updates the contact' do
        expect(response).to eq JSON.parse load_json('update_or_create_contact'), symbolize_names: true
      end
    end

    context "when contact isn't found" do
      let!(:email) { 'not_found@gmail.com' }
      let!(:body) do
        { properties: { email: email, firstname: 'Not', lastname: 'Found', hs_content_membership_status: 'active' } }
      end
      let(:response) { described_class.update_or_create_contact(email, body) }

      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/contacts/not_found@gmail.com?idProperty=email')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 404, body: '', headers: {})
        stub_request(:post, 'https://api.hubapi.com/crm/v3/objects/contacts')
          .with(
            body: 'properties%5Bemail%5D=not_found%40gmail.com&properties%5Bfirstname%5D=Not&properties%5Blastname%5D=Found&properties%5Bhs_content_membership_status%5D=active',
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_json('update_or_create_post'), headers: {})
      end

      it 'creates the contact' do
        expect(response).to eq JSON.parse load_json('update_or_create_post'), symbolize_names: true
      end
    end
  end
end
