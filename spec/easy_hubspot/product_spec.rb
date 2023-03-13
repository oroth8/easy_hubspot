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

  describe 'create_product' do
    before do
      stub_request(:post, 'https://api.hubapi.com/crm/v3/objects/products')
        .with(
          body: 'properties%5Bprice%5D=75.00&properties%5Bname%5D=Blue%20Jeans&properties%5Bdescription%5D=Worn',
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Ruby'
          }
        )
        .to_return(status: 200, body: load_product_json('create_product'), headers: {})
    end

    let(:body) do
      { properties: { price: '75.00', name: 'Blue Jeans', description: 'Worn' } }
    end
    let(:response) { described_class.create_product(body) }

    it 'returns a product' do
      expect(response[:id]).to eq '1174765028'
      expect(response[:properties][:price]).to eq '75.00'
      expect(response[:properties][:name]).to eq 'Blue Jeans'
      expect(response[:properties][:description]).to eq 'Worn'
    end
  end

  describe 'update_product' do
    context 'when product is found using product_id' do
      before do
        stub_request(:patch, 'https://api.hubapi.com/crm/v3/objects/products/1174789087')
          .with(
            body: 'properties%5Bprice%5D=100.00&properties%5Bname%5D=New',
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Authorization' => 'Bearer YOUR-PRIVATE-ACCESS-TOKEN',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: load_product_json('update_product'), headers: {})
      end

      let(:body) do
        { properties: { price: '100.00', name: 'New' } }
      end
      let(:response) { described_class.update_product(11_747_890_87, body) }

      it 'returns a product' do
        expect(response[:id]).to eq '1174789087'
        expect(response[:properties][:price]).to eq '100.00'
        expect(response[:properties][:description]).to eq 'New'
      end
    end
  end

  describe 'delete_product' do
    let(:success) { { status: 'success' } }

    context 'when product is found using product_id' do
      before do
        stub_request(:delete, 'https://api.hubapi.com/crm/v3/objects/products/1174789087')
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

      let(:response) { described_class.delete_product('1174789087') }

      it 'returns no content' do
        expect(response).to eq success
      end
    end
  end
end
