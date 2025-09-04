# frozen_string_literal: true

require 'spec_helper'

RSpec.describe EasyHubspot::Company do
  before :all do
    EasyHubspot.config do |config|
      config.access_token = 'YOUR-PRIVATE-ACCESS-TOKEN'
    end
  end

  describe 'get_company' do
    context 'when company is found using company_id' do
      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/companies/123')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_company_json('company'), headers: {})
      end

      let(:response) { described_class.get_company('123') }

      it 'returns a company' do
        expect(response[:id]).to eq '123'
        expect(response[:properties][:name]).to eq 'HubSpot'
      end
    end

    context 'when company is not found' do
      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/companies/4040')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 404, body: nil, headers: {})
      end

      let(:response) { described_class.get_company('4040') }

      it 'returns a 404 status error message' do
        expect(response).to eq({ status: 'error', message: '404 Not Found' })
      end
    end
  end

  describe 'get_companies' do
    let(:request_endpoint) { 'crm/v3/objects/companies' }

    context 'when companies are found' do
      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/companies')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          ).to_return(status: 200, body: load_company_json('companies'), headers: {})
      end

      it 'returns a list of companies' do
        response = described_class.get_companies
        results = response[:results]
        expect(results.count).to eq 2
      end
    end
  end

  describe 'create_company' do
    before do
      stub_request(:post, 'https://api.hubapi.com/crm/v3/objects/companies')
        .with(
          body: 'properties%5Bname%5D=McDonalds',
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Ruby'
          }
        )
        .to_return(status: 201, body: load_company_json('create_company'), headers: {})
    end

    let(:body) do
      { properties: { name: 'McDonalds' } }
    end

    it 'returns a company' do
      response = described_class.create_company(body)
      expect(response[:id]).to eq '123'
      expect(response[:properties][:name]).to eq 'McDonalds'
    end

  end

  describe 'update_company' do
    before do
      stub_request(:patch, 'https://api.hubapi.com/crm/v3/objects/companies/123')
        .with(
          body: 'properties%5Bname%5D=Staples',
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Ruby'
          }
        )
        .to_return(status: 200, body: load_company_json('update_company'), headers: {})
    end

    let(:body) do
      { properties: { name: 'Staples' } }
    end

    it 'returns a company' do
      response = described_class.update_company('123', body)
      expect(response[:id]).to eq '123'
      expect(response[:properties][:name]).to eq 'Staples'
    end
  end
end
