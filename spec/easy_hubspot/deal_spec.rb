# frozen_string_literal: true

require 'spec_helper'

RSpec.describe EasyHubspot::Deal do
  before :all do
    EasyHubspot.config do |config|
      config.access_token = 'YOUR-PRIVATE-ACCESS-TOKEN'
    end
  end

  describe 'get_deal' do
    context 'when deal is found using deal_id' do
      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/deals/11733930097')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_deal_json('get_deal'), headers: {})
      end

      let(:response) { described_class.get_deal('11733930097') }

      it 'returns a deal' do
        expect(response[:id]).to eq '11733930097'
        expect(response[:properties][:amount]).to eq '145.23'
      end
    end
  end

  describe 'get_deals' do
    context 'when deals are found' do
      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/deals')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_deal_json('get_deals'), headers: {})
      end

      let(:response) { described_class.get_deals }

      it 'returns a list of deals' do
        results = response[:results]
        expect(results.count).to eq 2
      end
    end
  end

  describe 'create_deal' do
    before do
      stub_request(:post, 'https://api.hubapi.com/crm/v3/objects/deals')
        .with(
          body: 'properties%5Bamount%5D=1500.00&properties%5Bclosedate%5D=2023-12-07T16%3A50%3A06.678Z&properties%5Bdealname%5D=New%20Big%20Deal&properties%5Bpipeline%5D=default',
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Ruby'
          }
        )
        .to_return(status: 200, body: load_deal_json('create_deal'), headers: {})
    end

    let(:body) do
      { properties: { amount: '1500.00', closedate: '2023-12-07T16:50:06.678Z', dealname: 'New Big Deal', pipeline: 'default' } }
    end
    let(:response) { described_class.create_deal(body) }

    it 'returns a deal' do
      expect(response[:id]).to eq '12259650914'
      expect(response[:properties][:amount]).to eq '1500.00'
      expect(response[:properties][:closedate]).to eq '2023-12-07T16:50:06.678Z'
      expect(response[:properties][:dealname]).to eq 'New Big Deal'
    end
  end

  describe 'update_deal' do
    context 'when deal is found using deal_id' do
      before do
        stub_request(:patch, 'https://api.hubapi.com/crm/v3/objects/deals/12259629202')
          .with(
            body: 'properties%5Bamount%5D=1600.00&properties%5Bclosedate%5D=2023-11-07T16%3A50%3A06.678Z&properties%5Bdealname%5D=New%20Big%20Deal%20UPDATE&properties%5Bpipeline%5D=default',
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_deal_json('update_deal'), headers: {})
      end

      let(:body) do
        { properties: { amount: '1600.00', closedate: '2023-11-07T16:50:06.678Z', dealname: 'New Big Deal UPDATE', pipeline: 'default' } }
      end
      let(:response) { described_class.update_deal(12_259_629_202, body) }

      it 'returns a deal' do
        expect(response[:id]).to eq '12259629202'
        expect(response[:properties][:amount]).to eq '1600.00'
        expect(response[:properties][:closedate]).to eq '2023-11-07T16:50:06.678Z'
        expect(response[:properties][:dealname]).to eq 'New Big Deal UPDATE'
      end
    end
  end

  describe 'delete_deal' do
    let(:success) { { status: 'success' } }

    context 'when deal is found using deal_id' do
      before do
        stub_request(:delete, 'https://api.hubapi.com/crm/v3/objects/deals/12259629202')
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

      let(:response) { described_class.delete_deal('12259629202') }

      it 'returns no content' do
        expect(response).to eq success
      end
    end
  end

  describe 'errors' do
    context "when trying to update a deal that doesn't exist" do
      before do
        stub_request(:patch, 'https://api.hubapi.com/crm/v3/objects/deals/9876543210')
          .with(
            body: 'properties%5Bid%5D=9876543210&properties%5Bamount%5D=123.00',
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_deal_json('not_found'), headers: {})
      end

      let(:body) do
        { properties: { id: '9876543210', amount: '123.00' } }
      end

      it 'raises a HubspotApiError' do
        expect do
          described_class.update_deal(9_876_543_210, body)
        end.to raise_error(EasyHubspot::HubspotApiError, 'resource not found')
      end
    end

    context 'when hubspot api returns a 404 reponse code' do
      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/deals/4040')
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

      let(:response) { described_class.get_deal('4040') }

      it 'returns a 404 status error message' do
        expect(response).to eq({ status: 'error', message: '404 Not Found' })
      end
    end
  end
end
