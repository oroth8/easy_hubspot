# frozen_string_literal: true

require 'spec_helper'

RSpec.describe EasyHubspot::Product do
  before :all do
    EasyHubspot.config do |config|
      config.access_token = 'YOUR-PRIVATE-ACCESS-TOKEN'
    end
  end

  describe 'get_product' do
    context 'when product is found using product_id' do
      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/products/1172707032')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_product_json('get_product'), headers: {})
      end

      let(:response) { described_class.get_product('1172707032') }

      it 'returns a product' do
        expect(response[:id]).to eq '1172707032'
        expect(response[:properties][:price]).to eq '25'
      end
    end
  end

  describe 'get_products' do
    context 'when products are found' do
      before do
        stub_request(:get, 'https://api.hubapi.com/crm/v3/objects/products')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_product_json('get_products'), headers: {})
      end

      let(:response) { described_class.get_products }

      it 'returns a list of products' do
        results = response[:results]
        expect(results.count).to eq 2
      end
    end
  end
end
